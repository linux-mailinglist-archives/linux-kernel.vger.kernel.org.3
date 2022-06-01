Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A48F53ACF6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 20:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiFASoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 14:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiFASoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 14:44:11 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7748A316
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 11:44:09 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-e5e433d66dso3867353fac.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 11:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hoMiNZYJrAfbuhQrGDapdgZz3vciw9pWtItN8E0slnw=;
        b=od8SH/Ys8gt43a9X8iPqlOmXKL+R0dCjlhw+7x4xGPXOwq1laMrsXksFC1Lpm6raHl
         hjrUwgOu2u+Hi9vpAU57nizmNVmQxC5bqUmEnE40bAbAQgdfYk09bmtPLwkCwtL8aEXu
         Kf9hVdDD4PbpqmbCNRmVbccAOAWKxv/fNNau/Bzv6/zNGHc1g8dBCBTpHBCc+mbl0z8j
         MAu+Ks11lNNkWp9UvJWpv8IPTnPBJ2sDIoDHwFr/ZIet9kPNM/wuRMtLqK1PIS5jzsMr
         PgOjbm19yYAIWXntuaURWePdXVw4oWAiEWBmLjid4em4AmXpN2PwsnaSmpAhJu9LOw5H
         sGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hoMiNZYJrAfbuhQrGDapdgZz3vciw9pWtItN8E0slnw=;
        b=Puvr1IiykuHSUDd01Q+3rMLHpAGUaxokCqrgKJ0Mb6Y8Pko82YBEpQHPccRlyjdbng
         8h0bb8lOnLHiTGQ3JkQ8QqjavlPF5WrBfxfg36HKl+LmHlWDC8xagRezwcnQUTa+/2jD
         EtCjmlNdzMG7i1Gos1pnH7lQO6WLJZGdIZDmdLGaXgR/9fQst9OX22meqEoEe8rExkNi
         /0Pkgn60DH2kLqJGjzaMC+HxEz8x9c7W5XSLG6C6bBKUmLBVPIlwv9oU9UsJwyXUW/ci
         WcTq83x5OzwzFHc242O3RpHZpca2ultQqCK6hsDC+f2eYHwZLNbNMpWiZXPtfurMKqYF
         fbGA==
X-Gm-Message-State: AOAM533SvNxgn9BU0dcC7ZdyzWqP2K39GbQpcoSlFicqr9le8dMdW2do
        ZRlSQyW9G28JKd/t15njUMaTrRZ2g6NSxRVrjN5vGT3zumg=
X-Google-Smtp-Source: ABdhPJwCz0AR8tTDpwwpJwpn0hIyY9iBlRIBDsDRqY0K1uMvlFffYks4KZRXhOfNGAabRjU1AhahBhnuTolYMzPy+eQ=
X-Received: by 2002:a05:6870:3105:b0:f2:9615:ff8e with SMTP id
 v5-20020a056870310500b000f29615ff8emr16722560oaa.200.1654109048402; Wed, 01
 Jun 2022 11:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <202205271546.oV14N2r8-lkp@intel.com>
In-Reply-To: <202205271546.oV14N2r8-lkp@intel.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 1 Jun 2022 14:43:57 -0400
Message-ID: <CADnq5_NOkqRsoqELkLayNU+xArXd-4RO=_banvJpXHtSW4-YdA@mail.gmail.com>
Subject: Re: [kbuild] drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1433
 amdgpu_discovery_get_vcn_info() error: buffer overflow 'adev->vcn.vcn_codec_disable_mask'
 2 <= 3
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Alex Deucher <alexander.deucher@amd.com>,
        kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Fri, May 27, 2022 at 3:46 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> [ kbuild bot sent this warning on May 4 but I never heard back and it's
>   May 27 now so sending a duplicate warning is probably for the best. -dan]
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
> head:   7e284070abe53d448517b80493863595af4ab5f0
> commit: 622469c87fc3e6c90a980be3e2287d82bd55c977 drm/amdgpu/discovery: add a function to parse the vcn info table
> config: arc-randconfig-m031-20220524 (https://download.01.org/0day-ci/archive/20220527/202205271546.oV14N2r8-lkp@intel.com/config )
> compiler: arceb-elf-gcc (GCC) 11.3.0
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1433 amdgpu_discovery_get_vcn_info() error: buffer overflow 'adev->vcn.vcn_codec_disable_mask' 2 <= 3
>
> vim +1433 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>
> 622469c87fc3e6 Alex Deucher 2022-03-30  1403  int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev)
> 622469c87fc3e6 Alex Deucher 2022-03-30  1404  {
> 622469c87fc3e6 Alex Deucher 2022-03-30  1405    struct binary_header *bhdr;
> 622469c87fc3e6 Alex Deucher 2022-03-30  1406    union vcn_info *vcn_info;
> 622469c87fc3e6 Alex Deucher 2022-03-30  1407    u16 offset;
> 622469c87fc3e6 Alex Deucher 2022-03-30  1408    int v;
> 622469c87fc3e6 Alex Deucher 2022-03-30  1409
> 622469c87fc3e6 Alex Deucher 2022-03-30  1410    if (!adev->mman.discovery_bin) {
> 622469c87fc3e6 Alex Deucher 2022-03-30  1411            DRM_ERROR("ip discovery uninitialized\n");
> 622469c87fc3e6 Alex Deucher 2022-03-30  1412            return -EINVAL;
> 622469c87fc3e6 Alex Deucher 2022-03-30  1413    }
> 622469c87fc3e6 Alex Deucher 2022-03-30  1414
> 622469c87fc3e6 Alex Deucher 2022-03-30  1415    if (adev->vcn.num_vcn_inst > VCN_INFO_TABLE_MAX_NUM_INSTANCES) {
>
> Capped to 4
>
> 622469c87fc3e6 Alex Deucher 2022-03-30  1416            dev_err(adev->dev, "invalid vcn instances\n");
> 622469c87fc3e6 Alex Deucher 2022-03-30  1417            return -EINVAL;
> 622469c87fc3e6 Alex Deucher 2022-03-30  1418    }
> 622469c87fc3e6 Alex Deucher 2022-03-30  1419
> 622469c87fc3e6 Alex Deucher 2022-03-30  1420    bhdr = (struct binary_header *)adev->mman.discovery_bin;
> 622469c87fc3e6 Alex Deucher 2022-03-30  1421    offset = le16_to_cpu(bhdr->table_list[VCN_INFO].offset);
> 622469c87fc3e6 Alex Deucher 2022-03-30  1422
> 622469c87fc3e6 Alex Deucher 2022-03-30  1423    if (!offset) {
> 622469c87fc3e6 Alex Deucher 2022-03-30  1424            dev_err(adev->dev, "invalid vcn table offset\n");
> 622469c87fc3e6 Alex Deucher 2022-03-30  1425            return -EINVAL;
> 622469c87fc3e6 Alex Deucher 2022-03-30  1426    }
> 622469c87fc3e6 Alex Deucher 2022-03-30  1427
> 622469c87fc3e6 Alex Deucher 2022-03-30  1428    vcn_info = (union vcn_info *)(adev->mman.discovery_bin + offset);
> 622469c87fc3e6 Alex Deucher 2022-03-30  1429
> 622469c87fc3e6 Alex Deucher 2022-03-30  1430    switch (le16_to_cpu(vcn_info->v1.header.version_major)) {
> 622469c87fc3e6 Alex Deucher 2022-03-30  1431    case 1:
> 622469c87fc3e6 Alex Deucher 2022-03-30  1432            for (v = 0; v < adev->vcn.num_vcn_inst; v++) {
> 622469c87fc3e6 Alex Deucher 2022-03-30 @1433                    adev->vcn.vcn_codec_disable_mask[v] =
>
> But this array doesn't have 4 elements

Correct, but num_vcn_inst can't be larger than
AMDGPU_MAX_VCN_INSTANCES (2) at the moment thanks to:
https://patchwork.freedesktop.org/patch/486289/

Alex

>
> 622469c87fc3e6 Alex Deucher 2022-03-30  1434                            le32_to_cpu(vcn_info->v1.instance_info[v].fuse_data.all_bits);
> 622469c87fc3e6 Alex Deucher 2022-03-30  1435            }
> 622469c87fc3e6 Alex Deucher 2022-03-30  1436            break;
> 622469c87fc3e6 Alex Deucher 2022-03-30  1437    default:
> 622469c87fc3e6 Alex Deucher 2022-03-30  1438            dev_err(adev->dev,
> 622469c87fc3e6 Alex Deucher 2022-03-30  1439                    "Unhandled VCN info table %d.%d\n",
> 622469c87fc3e6 Alex Deucher 2022-03-30  1440                    le16_to_cpu(vcn_info->v1.header.version_major),
> 622469c87fc3e6 Alex Deucher 2022-03-30  1441                    le16_to_cpu(vcn_info->v1.header.version_minor));
> 622469c87fc3e6 Alex Deucher 2022-03-30  1442            return -EINVAL;
> 622469c87fc3e6 Alex Deucher 2022-03-30  1443    }
> 622469c87fc3e6 Alex Deucher 2022-03-30  1444    return 0;
> f39f5bb1c9d68d Xiaojie Yuan 2019-06-20  1445  }
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
> _______________________________________________
> kbuild mailing list -- kbuild@lists.01.org
> To unsubscribe send an email to kbuild-leave@lists.01.org
>
