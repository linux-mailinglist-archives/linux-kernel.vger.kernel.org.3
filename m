Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3884E591526
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiHLR7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 13:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbiHLR7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:59:33 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C319EB285C
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 10:59:31 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w196so1929333oiw.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 10:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=wx/ERrMm2Bc5z30Jh0fJguExB7AP6Vqb6sZ78FbzlIc=;
        b=12w+EJB/sEwbLd/xs/CAahxStbaWmmBiZ7/6sAa+6CdJU6cAoJDIcIQxxGnUkjjaQM
         0dzpodgbSDalE87E63cYL5a30A4zzFWgCYThxsuvujt9OsBO029gJ1VNywAuml4DWEeF
         cnwybzvzR5T7Ds3PfcKN/Yu9v8olhe2ltwd449JZ0eEK7UTkueSsPsp3474kso5SrwHJ
         kzjWvd/0nsFNv18juyeNMLzuLL7RLqlru6ncMhITBKEKslrDmby3/WAbTig1hS1KNX6/
         iBGHNHHMTs7uTXOrse9MG1P6FCYAV2AzapLDR4W7xWlAd5/SzMQL339eUI1985/YtYp8
         Ntng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=wx/ERrMm2Bc5z30Jh0fJguExB7AP6Vqb6sZ78FbzlIc=;
        b=dO5tWhhc7RVLWx2g4JaSGjk91BOkhoRHG2Dl1M6JuiVtYhiiOwqZM+AQns8t3SH2m2
         0AfIBvuPHB9bmOz8No0MYa1w9d2P8uXe16K+tyL8YHCZnrBLseQ4aKrMOAoCGY5VzTeR
         ECErOvA35sXfTjLO3u1tvXCoy8j1CRk1ZBx+a9YYAIOvuHkZ/ef7FYQxeCSRRlJFuqUu
         c4mx/1l5UcZl8XKEVTTDYW4FaBqZeOfhxSr4g5UKSuGidRe3wYlAbKOR7BZNqFyi7geH
         7O2nIIilSXHDI6BFWqK5y5sVfmrI632omTt5h+2tXX4t5Z7rL7+O9e6rYVe5jZl/RCfB
         yy3Q==
X-Gm-Message-State: ACgBeo0E1L9XLTHPkS/+O4yy4WQSHB2adhMnhgkk0/bGs2RqzB0Ozxzc
        DVmincV4fzrcvuvTz3ZsC12k6600XhG0oXG0yRLVCw==
X-Google-Smtp-Source: AA6agR4H/4HEp5HiQ3K7eMQPJk/D2MqeGwsNgF263hHmfAZK8ZjNFpJcVSGRNt8i/L2ebhOBPa9x8Ov2gn1R7NNPLpI=
X-Received: by 2002:aca:a913:0:b0:343:fe9:951a with SMTP id
 s19-20020acaa913000000b003430fe9951amr6118000oie.94.1660327170882; Fri, 12
 Aug 2022 10:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <e38aa76d-6034-4dde-8624-df1745bb17fc@www.fastmail.com>
 <YvPvghdv6lzVRm/S@localhost.localdomain> <2220d403-e443-4e60-b7c3-d149e402c13e@www.fastmail.com>
 <cb1521d5-8b07-48d8-8b88-ca078828cf69@www.fastmail.com> <ad78a32c-7790-4e21-be9f-81c5848a4953@www.fastmail.com>
 <e36fe80f-a33b-4750-b593-3108ba169611@www.fastmail.com>
In-Reply-To: <e36fe80f-a33b-4750-b593-3108ba169611@www.fastmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Fri, 12 Aug 2022 13:59:19 -0400
Message-ID: <CAEzrpqe3rRTvH=s+-aXTtupn-XaCxe0=KUe_iQfEyHWp-pXb5w@mail.gmail.com>
Subject: Re: stalling IO regression since linux 5.12, through 5.18
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 12:05 PM Chris Murphy <lists@colorremedies.com> wro=
te:
>
>
>
> On Wed, Aug 10, 2022, at 3:34 PM, Chris Murphy wrote:
> > Booted with cgroup_disable=3Dio, and confirmed cat
> > /sys/fs/cgroup/cgroup.controllers does not list io.
>
> The problem still reproduces with the cgroup IO controller disabled.
>
> On a whim, I decided to switch the IO scheduler from Fedora's default bfq=
 for rotating drives to mq-deadline. The problem does not reproduce for 15+=
 hours, which is not 100% conclusive but probably 99% conclusive. I then sw=
itched live while running the workload to bfq on all eight drives, and with=
in 10 minutes the system cratered, all new commands just hang. Load average=
 goes to triple digits, i/o wait increasing, i/o pressure for the workload =
tasks to 100%, and IO completely stalls to zero. I was able to switch only =
two of the drive queues back to mq-deadline and then lost responsivness in =
that shell and had to issue sysrq+b...
>
> Before that I was able to extra sysrq+w and sysrq+t.
> https://drive.google.com/file/d/16hdQjyBnuzzQIhiQT6fQdE0nkRQJj7EI/view?us=
p=3Dsharing
>
> I can't tell if this is a bfq bug, or if there's some negative interactio=
n between bfq and scsi or megaraid_sas. Obviously it's rare because otherwi=
se people would have been falling over this much sooner. But at this point =
there's strong correlation that it's bfq related and is a kernel regression=
 that's been around since 5.12.0 through 5.18.0, and I suspect also 5.19.0 =
but it's being partly masked by other improvements.

This matches observations we've had internally (inside Facebook) as
well as my continual integration performance testing.  It should
probably be looked into by the BFQ guys as it was working previously.
Thanks,

Josef
