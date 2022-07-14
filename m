Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD69574176
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 04:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiGNCeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 22:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiGNCeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 22:34:14 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697DD248FA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 19:34:12 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c131-20020a1c3589000000b003a2cc290135so2311337wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 19:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b3TrDmoW9oBN2ZfcS9931eEvANmE2rrBTqfquIYx58Q=;
        b=DXcK0Aum+xKmbAuTwl+9oNeJFU+tW5NF1N3L7fYgw76YX4A0B15FmGo5dgqQd1/OAK
         i3vj8TFtn2P7EaMRkYYjhBlbubxDOma6XzCHiQaVXZKP6c216oZ+o0c3dl019+Onh4OT
         jbsMq031SNd+eGysp55kpYxeaILouGSIhN9v2hfJJFOdUxAU1g7AT+FRQyshLskKuCO/
         2yZ3gHeQ8FCoiMDAGTPFIflefBZENjYE/OYylHqE/sfMRJuxj0DBTSpk0QtB0w82Rkzl
         f72ZDN7Na0ZgVQVCnVOWqwXlWcYJMytQZetRnlUsBPZgatSwaA2SWwTHOvH4d4ctX3hU
         aqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b3TrDmoW9oBN2ZfcS9931eEvANmE2rrBTqfquIYx58Q=;
        b=4++L0uvowNHxKBLkVWzXwW0xk2WR1jnAvUcYPiyQAHgSsc8NaCZ04zhw8AkXs6rp6/
         W19S9Z7IgDdvRdhlNKsTFcL1J+aMGIY6Ji20PvJYlh8AMJGTEw89JcvgL4p3yZU1MnAP
         1t2TTpE6HgpMR9NUU8DC1irhkKYFsGTNkEp1zx/NBGeiM9zb0qpxQi7OpiSGAfnZo391
         u7T6bLazxWjBA8+Pi/kW1T8ubOGIs6y5Iv+Bf3oYTAEMPCbBVcXVgFtF9S2+8cWQ8/Pa
         bDbxn+E5FoaOCHv6nuRxa6QfixuH/SERWcb6AbCrVcx1nnPRH6r3s3dqPwoc/YUfYeaO
         vBSA==
X-Gm-Message-State: AJIora9ZkzVuz8BfmVyXiEap1SVv5QPEklFNeqelWG094hf6AeIFyNKD
        S81vQ+27n0Ny0UHWiBYt+rCi2NVmLBSyGrnTsY+t
X-Google-Smtp-Source: AGRyM1tDKJim+CxDW2bY+R0tUKURKfcZpGwJ5c5Rtrh4kviPSM9+GSsLBHW6KJ8aQVCDtLlWxtDW8900w0celVYD+W8=
X-Received: by 2002:a05:600c:4f95:b0:3a2:e2af:2090 with SMTP id
 n21-20020a05600c4f9500b003a2e2af2090mr6697106wmq.158.1657766050246; Wed, 13
 Jul 2022 19:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220714012421.55627-1-xiujianfeng@huawei.com>
In-Reply-To: <20220714012421.55627-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Jul 2022 22:33:59 -0400
Message-ID: <CAHC9VhRM8_Eo9rCL88LLgY7e=soKpSSRK2Zftt9e24GC3A_yMQ@mail.gmail.com>
Subject: Re: [PATCH RESEND -next] lsm_audit: Clean up redundant NULL pointer check
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 9:27 PM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> The implements of {ip,tcp,udp,dccp,sctp,ipv6}_hdr(skb) guarantee that
> they will never return NULL, and elsewhere users don't do the check
> as well, so remove the check here.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/lsm_audit.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

Hi Xiu Jianfeng,

We just changed LSM maintainers earlier this week, and while I haven't
forgotten about your patch (I reviewed it previously), it is too late
in this current release cycle (-rc6) to merge non-critical fixes.
This would go into the LSM tree after the upcoming merge window.

Thank you for your patience and understanding.

-- 
paul-moore.com
