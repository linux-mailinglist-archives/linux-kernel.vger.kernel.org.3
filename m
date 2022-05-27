Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA9B5358E5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 07:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243583AbiE0FwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 01:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbiE0FwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 01:52:10 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE112E2794;
        Thu, 26 May 2022 22:52:09 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id d22so4168700edj.4;
        Thu, 26 May 2022 22:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=o0TsDTzVWppTPCx2R4Hy7J51cpcj3p1lUYm2XC/H4lg=;
        b=glKjVk7syc34w4mICRNMJu0ilDcg10vhUplxhbx5404kAZtUq1/6zYjzNAZjiIMYSA
         /heqB+OSWEGBENmHoAO97bZ+CLeEPtxi6fKMOdJVL9QzcTo//F0sbZLbRrNM9PbU9D/Z
         Xb4X09xa6z2lQBeYq+LPHZh42fNIo79guxqPXZXSGTpXVVrShfTjEQWSMf7kVgpZilkg
         beoj/m/m1bugn/0ZG9jMlkkd37huHXfNwsGlPayo0MRVFZ5NDI8m+Y6G/cD/tsZVFQSV
         Hs60apaK7AlnIuU9C/q1NrEeA2tOzZKzuf3L7BMn4iMXKSv/ydG5fH2N+P5orAWp1HVQ
         Jacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=o0TsDTzVWppTPCx2R4Hy7J51cpcj3p1lUYm2XC/H4lg=;
        b=o0tt6X3DjoBltaFqIHq8EBOL2fm1YPf8G2thWbw5EyMyU4xekzSZdhUqnnm9VrXyW1
         lsTe7/VuUCpS/FWdOWi4i8emK/+d5Kry996IbtDKhkN9VWXewoN5KS3Pek1/ZA4TNHjQ
         XwDHr0xoVyMeYMkPFl68MbmzoQBUPAPmtwTHgeRxFzMXYukIwdO/pYwaQVvEbidFRTz2
         V07ZN4LzGJT+TYx7nN8d6G/vYK6D+0gp3G2GlVppxGihL81DX0ZW041m47u+7vPLx5aW
         fnPGvfgUtW1SdgkLzI2p5iKNqrehNlQC+XsUwEvb6s7l/Bsh2l/dVUTTPGa94DEFo1W+
         rK4w==
X-Gm-Message-State: AOAM532N+NgERU05IcXEFizfAyuAxw9eja7Uk2Xll3FqzB0AgmP0L+8E
        2XrCEKTTg981t1MATjAfJsbqZCWIyr0YqsOWHHEPlGaVh/ZxhCjj
X-Google-Smtp-Source: ABdhPJwSu46XRZ5LBbBzfunrf7upIs4isceABvMMmYwxQ0LbQyu/K+cqGyAsT6asEyHl5VQhbKr5Fk7sbTN5PQvyYag=
X-Received: by 2002:a05:6402:3491:b0:42b:635a:efaf with SMTP id
 v17-20020a056402349100b0042b635aefafmr25387855edc.135.1653630728363; Thu, 26
 May 2022 22:52:08 -0700 (PDT)
MIME-Version: 1.0
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Fri, 27 May 2022 13:51:42 +0800
Message-ID: <CAD-N9QXY57RvFwGQvh8U7WBc3JCX-0kpqB6+fZ=oJJtHmFdUwg@mail.gmail.com>
Subject: Null Pointer Dereference in sd_zbc_release_disk
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi maintainers,

I found a NPD(Null Pointer Dereference) in sd_zbc_release_disk function.

There are two definitions of sd_zbc_release_disk:

#ifdef CONFIG_BLK_DEV_ZONED
void sd_zbc_release_disk(struct scsi_disk *sdkp);
#else /* CONFIG_BLK_DEV_ZONED */
static inline void sd_zbc_release_disk(struct scsi_disk *sdkp) {}
#endif

When CONFIG_BLK_DEV_ZONED=y, the function implementation is as follows:

void sd_zbc_release_disk(struct scsi_disk *sdkp)
{
    if (sd_is_zoned(sdkp))
        sd_zbc_clear_zone_info(sdkp);
}

static inline int sd_is_zoned(struct scsi_disk *sdkp)
{
    return sdkp->zoned == 1 || sdkp->device->type == TYPE_ZBC;
}

In drivers/scsi/sd.c, sd_probe() allocates sdkp with kzalloc(). If
errors occurred before the assignment "sdkp->device", after the
allocation, it will triggers a NPD in sd_is_zoned.

I am not familiar with kernel configuration. Does anyone have a
suggestion to fix this NPD?

I really appreciate any help you can provide.
--
My best regards to you.

     No System Is Safe!
     Dongliang Mu
