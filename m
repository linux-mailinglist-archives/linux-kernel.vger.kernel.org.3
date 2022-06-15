Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC15254D566
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 01:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350417AbiFOXdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 19:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241580AbiFOXdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 19:33:50 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3022519028
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 16:33:48 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g4so659549wrh.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 16:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g5KefneXJrDvqUoqQmaGedJ+cFbJAO8aiLnwLvVjblw=;
        b=Lh822BC9eea8HopwavAIKCLZVPWprgw7IeIQ1CPIO02Fjto9URIyONCey0O0zTlvTB
         P8OWW3c4B5VM6qMwDT1o1WL6oH1qlnGFIRBKoOQavee0kV/ReunaoQVy/a4dRatCioVV
         mQuTbqEffYYrORVnq9DnCUdOZ8jonrpLxgf5kchPKePUG/5FG/eOL4PEUipaCh52kpuT
         FatM0xmTJJqcWZm+RDcgF7r3iBuoQa4ci/bOFsXd0a8wIXxMcCUp015KpMKwogQ2mmGW
         4Qibi3CMBlesvOFXBq57pOZmozoKS4VX45mpQu4Twor6aje2GpkT30fDuR1t3jRa5Fmi
         fEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g5KefneXJrDvqUoqQmaGedJ+cFbJAO8aiLnwLvVjblw=;
        b=G2nqBarY6g8goQfJRapksLiw6dLRwuKx9fhUofUlD5a5s5gO/czJ7VZAvdQyFJkmhj
         AnnW/oN1oV382mK9Xvpzl0JmSO5c/AooTHUPaTSHBpZ/d9VxFp7B5qTzLV+9W8htD8n0
         NBu78nNbMpNKneWAeNwrjokq50lpv/xprVTgTZhN15R1QZtscXhAO4MNfaMukxlsXHoH
         U4+XKdGCmygn1ibOsXIHazdV4ZS/NGZYBm73eM4k9JXgUYyz+x5MtHCow22YQce7OJHa
         v/tlsKAwCDGFnXNvOb4Zg6Orc4Dqu/tCDbCZ0BgczZcF1hMA3n8EjMqaOvCRgeoq+QZD
         A/og==
X-Gm-Message-State: AJIora8yE5qr8JNEMgSrpUB4HDrA4WXFG+PbvFfuuViS64RK1mGdiiC3
        eLcCPmVQLgKk9I6PE78CQ3mQFN1lxKKF+0jir4O5Q43MntSE
X-Google-Smtp-Source: AGRyM1sY3fekgthl8FSRwVjkGPBP5d0/rq2O0Lip1IvTEQzV7E45c/TYtF7WDlgop3djBs+KrCf0YffQXZ5d7TTHF9g=
X-Received: by 2002:a05:6000:1447:b0:21a:278a:181c with SMTP id
 v7-20020a056000144700b0021a278a181cmr2021261wrx.161.1655336026705; Wed, 15
 Jun 2022 16:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220615154432.314974-1-cgzones@googlemail.com>
In-Reply-To: <20220615154432.314974-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 15 Jun 2022 19:33:35 -0400
Message-ID: <CAHC9VhT2nwdhhQg4Ak8sKV5YSAhRP=0XECyOkPE0=bAdKPvnhQ@mail.gmail.com>
Subject: Re: [PATCH] audit: free module name
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Eric Paris <eparis@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 11:44 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Reset the type of the record last as the helper `audit_free_module()`
> depends on it.
>
>     unreferenced object 0xffff888153b707f0 (size 16):
>       comm "modprobe", pid 1319, jiffies 4295110033 (age 1083.016s)
>       hex dump (first 16 bytes):
>         62 69 6e 66 6d 74 5f 6d 69 73 63 00 6b 6b 6b a5  binfmt_misc.kkk.
>       backtrace:
>         [<ffffffffa07dbf9b>] kstrdup+0x2b/0x50
>         [<ffffffffa04b0a9d>] __audit_log_kern_module+0x4d/0xf0
>         [<ffffffffa03b6664>] load_module+0x9d4/0x2e10
>         [<ffffffffa03b8f44>] __do_sys_finit_module+0x114/0x1b0
>         [<ffffffffa1f47124>] do_syscall_64+0x34/0x80
>         [<ffffffffa200007e>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
> Fixes: 12c5e81d3fd0 ("audit: prepare audit_context for use in calling con=
texts beyond syscalls")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  kernel/auditsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks Christian, I just merged this into audit/stable-5.19 and I'll
send this up to Linus as soon as the automated tests finish their
runs.

--=20
paul-moore.com
