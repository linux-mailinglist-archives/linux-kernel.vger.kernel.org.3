Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53B2591817
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 03:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiHMBVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 21:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMBV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 21:21:29 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 Aug 2022 18:21:28 PDT
Received: from cardinal.elronnd.net (cardinal.elronnd.net [71.19.150.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFB40AA3FC
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 18:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=IufNUSwQPmP6
        0Z06Trf+8MEW5Pfsa4wMWIEBvVYspQw=; h=subject:to:from:date;
        d=cardinal.elronnd.net; b=hrmMQjuMdDHyx6f6IPTa/XNXOgumZAm5baHYMJahXUwe
        216wam8y5H8ksZraus2tcYW4L7Dk7l19p1kEEgPBAp6IgYPz6om5BjS+Aoe2VcBjKSgzzV
        3ZY1JP8O4yLF6IejnHnXpEppuiwnDBac1UX7zQQ7sgcrgXectccN11TX8=
Received: from localhost (localhost [127.0.0.1])
        by cardinal.elronnd.net (OpenSMTPD) with ESMTP id c6671b0d
        for <linux-kernel@vger.kernel.org>;
        Fri, 12 Aug 2022 18:14:48 -0700 (PDT)
Date:   Fri, 12 Aug 2022 18:14:48 -0700 (PDT)
From:   Elijah Stone <elronnd-linux@elronnd.net>
To:     linux-kernel@vger.kernel.org
Subject: Futex wait is not interrupted by signals if no timeout is provided
Message-ID: <88516d10-bd53-9725-77f5-2772a6c784@elronnd.net>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've observed a strange behaviour of futexes that I believe to be a bug.  If a 
signal is delivered while a futex wait is in progress, the wait will be 
interrupted, but only if that wait had a timeout.  I expect it to be 
interrupted regardless of whether a timeout is provided.  The following 
runnable snippet demonstrates this:

void handler(int) { printf("SIGINT\n"); }
int main() {
 	signal(SIGINT,handler);
 	int i=2;
 	printf("1\n");
 	syscall(SYS_futex, &i, FUTEX_WAIT, 2, &(struct timespec){.tv_sec=1000});
 	printf("2\n");
 	syscall(SYS_futex, &i, FUTEX_WAIT, 2, NULL);
 	printf("3\n");
}

Pressing ^C once causes the first wait to terminate, and '2' to be printed. 
But repeatedly pressing it after that does not allow the program to make 
progress.
