Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241944F9605
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbiDHMrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiDHMrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A677EBAE9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 05:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649421916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=khBPZtzPFEMx9dKIM9CWO7Q/Lm+eAtWPqukaOGv/i8A=;
        b=YLtnpIsC0V7winnbPDIk8ihc1bA6iZGyvRj9ARC3Px6IupPR31DrGO1wJvQ37eQxfkUHHW
        pdU1brJZHsIjdqPWtFJl3TsIX8uPMC77CL1FaYl7weSAgIAJv1GKpcBy1UIe/GopodhpcN
        r+p1QFE2oLFswtseQaHaobOI3YKJRLQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-310-F8bNETrINdy56VvTPNPvdg-1; Fri, 08 Apr 2022 08:45:15 -0400
X-MC-Unique: F8bNETrINdy56VvTPNPvdg-1
Received: by mail-lf1-f69.google.com with SMTP id t14-20020ac243ae000000b0046b81f8ac2cso1144362lfl.19
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 05:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khBPZtzPFEMx9dKIM9CWO7Q/Lm+eAtWPqukaOGv/i8A=;
        b=LRfso/wEcV156nfegNhFAPueKGEl/cRq6nUNkiqgH0nlUVgrOnXwvpRd2CPxx/dLja
         Ah1C3+6sBpMQbsW7Sfu8tCBtpDBa7SQpa0sTC1vAZUqrvFO2BTbojUd/KMvCa0VNkGjX
         Kg6tlrOcncoGh/IEsAFPoJ9ro/54THx0wHHVrz1AbT0816qbhOG2ELWTHww7WOTLeMNz
         5r0R0kWP5jGQOrrHGNVkmkhH2QbC7PV6kC/iPJB012vZeftC9PeS5RkAgOz58VysJW0s
         u2OsbYu6pyu5GklRmylqQO7wpPEKj2RoQKbtH/LhOBbpbEdiQ1yJdXEhm7JHC4xUxepF
         nIAQ==
X-Gm-Message-State: AOAM533ELch248WtVMjyD4R5aSRDvDuYsnX7c6Nb24AweKM7YwzQN2bf
        KpyA6hcPdnhEXyRA7TgJ28ASH/bXAmpBINLBrtCHSuv4QsLvEl3Aq3zJH69YUUpokQT/Rr+1Cbz
        kH58qK2WEcSTUnbGtNtXCt45K67qgQK/waZFh6zZ4
X-Received: by 2002:a05:6512:158d:b0:44a:6522:f98f with SMTP id bp13-20020a056512158d00b0044a6522f98fmr12476801lfb.608.1649421913224;
        Fri, 08 Apr 2022 05:45:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxifoUmW3lR7s6bWQ1QaUPysHRDA51bV3Mjmn5J1/ODHj+CUYXo/iK2FzHxX3hDX/jFtBf6eHMKV1gEJAu6iCE=
X-Received: by 2002:a05:6512:158d:b0:44a:6522:f98f with SMTP id
 bp13-20020a056512158d00b0044a6522f98fmr12476781lfb.608.1649421912940; Fri, 08
 Apr 2022 05:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <CA+QYu4qTtXgVegAd7S5bjJQye+kmtPaFau4dg3YPU2tH9faBjg@mail.gmail.com>
 <175195a9b7840e883677c6f351ee186089ab2b6d.camel@HansenPartnership.com>
In-Reply-To: <175195a9b7840e883677c6f351ee186089ab2b6d.camel@HansenPartnership.com>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Fri, 8 Apr 2022 14:45:01 +0200
Message-ID: <CA+QYu4oKwOwKYJB0_SezXWaMWa9Obp2=nLd-2_bKx-jSAu1TDw@mail.gmail.com>
Subject: Re: RIP: 0010:ahd_init.cold+0x96/0x98 [aic79xx] - 5.17.0
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org,
        CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 5, 2022 at 5:33 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2022-04-05 at 09:14 +0200, Bruno Goncalves wrote:
> > Hello,
> >
> > We've been hitting the panic below when testing mainline kernel. More
> > logs can be found on [1] and CKI tracker [2].
>
> When was the last time this driver passed the test?  I'm asking because
> nothing significant has changed in this driver for a while and the
> trivial changes all seem to check out.

Hi James,

Sorry for the delay in replying to you. Do you think it could be some
patch from d51b1b33c51d147b757f042b4d336603b699f362 or
23d1dea55520c5cf89849279cd25de4da8392687 ?

I was able to reproduce it using the CKI kernel from d51b1b33, but not
from commit 2fce7ea0.

We don't have a kernel build for 23d1dea5, but if you want I can try
it next week.

Also, it seems I can only reproduce it on kernel build that adds some
debug flags when we build with selftests enabled.

kernel build: https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/03/23/499569088/build_x86_64_redhat:2242251830/kernel-mainline.kernel.org-x86_64-d51b1b33c51d147b757f042b4d336603b699f362.tar.gz
kernel config: https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/03/23/499569088/build_x86_64_redhat:2242251830/kernel-mainline.kernel.org-x86_64-d51b1b33c51d147b757f042b4d336603b699f362.config

Bruno


>
> James
>
>

