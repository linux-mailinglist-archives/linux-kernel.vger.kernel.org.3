Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0B94E479C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbiCVUh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbiCVUhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:37:24 -0400
Received: from valentin-vidic.from.hr (valentin-vidic.from.hr [IPv6:2001:470:1f0b:3b7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6EFCC3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 13:35:56 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id 9A53227E5F; Tue, 22 Mar 2022 21:35:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=valentin-vidic.from.hr; s=2020; t=1647981345;
        bh=xUB6V3iJ7Xhl9pkuQnVjET2rGiobVvuBo0GYXUwuhjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qSZ1tXNx6dsXB11Y0eDkV6td4I/YzYN2KgQeGOqnNVnvX1KrYyL4RTTDPLoHERI+v
         KOA699NaYBBPpYdkySXPQaDPizbFBRqw5mKykyZancXaQlh9ACF7rReveCxEN/t3v7
         J6B49daX7kqg5a+9HqO/7zC/cAgB59oLKHcljr5jXj0PpK6TI8TXTMBKj1bPD6QLbz
         fJ8ko5d/9x4xu8Ep7JF//raVlMj5qoB1qhI4wdGrkayKlVtjl1kMPKsSk1dhZZuZE7
         I6HjYQlq6bvSJlBR+jRN39lvpCb8as0+xDFT0Hv0xbf/s5clQJ9Eu31avcoYoPK7gy
         63/RESpOYjKlBwmDXF9H290fCenH2q1RCzUWEigX2MpOzlzuOvM0EVyCjENdFWyIbR
         Abmqcm+vRRlDcz96v5mlI7hLJe0HzWaYVrzSce07hg3aNt1tv69dxWiCR50e+q1Krj
         s04SlTuk4FqFc7h7NLwoS6kiBvV2Vkg5RwnESJMiIti0V2q5gE9NT/5WlgEgmUaVy7
         O2DqLZ0DxtKAfIqKeJxwF7j6Y/4OFsSaidHCRqPBmKZLyiSkpq7k3cWWDyuiehTnkH
         MG/oN2rsjs/XCvdiVFH1I3oeLy2A4OYbDXIwQosJe6t9SUf/vG2Zyqkgzca8IQQnAB
         lUIYmqZP5s/5Et1S0AiMbXxA=
Date:   Tue, 22 Mar 2022 21:35:45 +0100
From:   Valentin =?utf-8?B?VmlkacSH?= <vvidic@valentin-vidic.from.hr>
To:     Joseph Qi <jiangqi903@gmail.com>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        linux-kernel@vger.kernel.org, Tuo Li <islituo@gmail.com>,
        Dayvison <sathlerds@gmail.com>, ocfs2-devel@oss.oracle.com,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [Ocfs2-devel] [PATCH] ocfs2: quota_local: fix mount crash of
 filesystems with quota enabled
Message-ID: <YjozIZ3j8Oczc7W8@valentin-vidic.from.hr>
References: <20220322031215.1449435-1-vvidic@valentin-vidic.from.hr>
 <0bb64f66-6343-72d4-3948-6c6dd49be41a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bb64f66-6343-72d4-3948-6c6dd49be41a@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 03:32:35PM +0800, Joseph Qi wrote:
> Thanks for pointing this out. My fault when reviewing the introduced commit.
> But this change will lead to access uninitialized dqi_gqlock when
> ocfs2_global_read_info() fails.
> How about the following way?

Looks good and works for me :)

Tested-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>

-- 
Valentin
