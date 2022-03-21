Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC1F4E2DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350992AbiCUQR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242154AbiCUQRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:17:52 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3496625285
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:Subject:Cc:To:From:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=mutIz+F+iXIl9BXKDafSxh5xzTzg6I1cGBlrVf2zO1g=; b=jVv7RpEc2nvegrnrZtwd2FDjm7
        VyhMNmN/3PZkFoctUaCF1QJ/aylhuRCWxItLf61+SCWlogPDEoAD/1J7xjI6Gd9W2Z2xXTz71Iyeg
        oeJFd/coAFxr8XkVoi3MJEyWInBjO1ckilc4VGl1iEe7qHSZzWl5W3jOoTtWHxkB99shVnLwgwdav
        pwOYwLfm39qt3fHEqfSwE77UFUvxhN1fS3pxlO6GmUGmHjyNVcymy19lImnFehgB5zHGx5EgY1Jsc
        tUR9b8qbHInYEnoTnORhvkkPLlHs9g+qCAt4Zl5ln3p22L8jpD4ca5Z/Ebj36UlhPItD5b9aREzAm
        CsjM0qRQ==;
Received: from [187.39.124.208] (helo=[192.168.0.110])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nWKhX-0005Em-ME; Mon, 21 Mar 2022 17:16:14 +0100
Message-ID: <6dac422b-d509-b863-0b31-98a07808ac0d@igalia.com>
Date:   Mon, 21 Mar 2022 13:15:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     computersforpeace@gmail.com, f.fainelli@gmail.com
Cc:     gpiccoli@igalia.com, "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        opendmb@gmail.com, gpowell@broadcom.com, justinpopo6@gmail.com,
        mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Question about the Broadcom Always On register panic handling
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian and Florian, I'm studying the panic notifiers and found one
added by you in the commit 0b741b8234c ("soc: bcm: brcmstb: Add support
for S2/S3/S5 suspend states (ARM)". Basically, the handler is very
simple and the only thing it does is:

/* from drivers/soc/bcm/brcmstb/pm/aon_defs.h */
#define AON_REG_PANIC		0x20
#define BRCMSTB_PANIC_MAGIC	0x512E115E

/* from drivers/soc/bcm/brcmstb/pm/pm-arm.c*/
brcmstb_pm_panic_notify() {
	writel_relaxed(BRCMSTB_PANIC_MAGIC, ctrl.aon_sram + AON_REG_PANIC);
}

This write happens on panic time, but I couldn't find any
information/documentation about the AON register and what effectively
happens when this write is completed. Does the SoC reboots or anything
like that?

Any information that helps me to document such panic event is very
welcome, and in case you have AON documentation, it'd be also pretty great!

Thanks in advance,


Guilherme
