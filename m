Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF2652693D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 20:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383307AbiEMS1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 14:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383306AbiEMS0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 14:26:49 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E441E3DF
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 11:26:47 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id i17so8701508pla.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 11:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=DWr88KXO8yOHtjVU6pqQ0YSnL6a33gTkT/ttelbBfAE=;
        b=V3SjT18ZDrdF4vkkT3kKufo35FXfHRIbwvhsO5oJmLbV/qmmImWjKHOcxehhAdW2cz
         dqi6ggxT+QQUqxqQa5vZlqVUlTbvKdEqgvDJ0KlXmrH4/wc+fknVNp6IxdOl1ymG4Rpv
         MGOklopUKYWTQkbnkNyWseHpDC2FbOBdCQV4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=DWr88KXO8yOHtjVU6pqQ0YSnL6a33gTkT/ttelbBfAE=;
        b=NdLf1mM/W5OG0kf0Jk59/2kX1FIgpNSB69r7PutopCy5Wh+fH5g2GzF7azCAdxC1nj
         47ewFcNd+kL5myY3HqclK+0PnkNqoootWEVNTj0JqD2kpiPS2F/bxNT2Q/dITQsonGGI
         2qdKb3h87C4tdTLeCe7S+cuqFVaukJof+/5+YysRv6gJszcfyp0MCK6q0YCpmYJRsAo+
         rJRXdDPT4BaHHhuk7JQyGbuP4hNpItUVPoJGdUrbKBurM25iTYu+6UQENRjApNlT5LqT
         erbd8ZhdyYN0kiUjuzX3x6Dgb4xAoFhXYN60q12VmIpENC65DsEH2tCl9nKHggFXx3QA
         jXVw==
X-Gm-Message-State: AOAM530oBHSdM6RsYfftjGpGBDSMCONxZZghNz030ocyVnCQHr53y7A0
        zk8FRjq1kLAWmXvvtVgV2cRvYw==
X-Google-Smtp-Source: ABdhPJzw+kzrYWctB0MM/hgYN5NeQJBlpaBicGatEKSdKPEQfZwTCnjWNjioRBrl/vmRGrxHaK9SGw==
X-Received: by 2002:a17:902:ecca:b0:15e:8971:4540 with SMTP id a10-20020a170902ecca00b0015e89714540mr5596247plh.43.1652466407389;
        Fri, 13 May 2022 11:26:47 -0700 (PDT)
Received: from ?IPv6:::1? ([2607:fb90:3304:3e0:87ad:1d43:6a6e:afdd])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b0015f2d549b46sm2150754plh.237.2022.05.13.11.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 11:26:47 -0700 (PDT)
Date:   Fri, 13 May 2022 11:26:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mike Snitzer <snitzer@redhat.com>,
        Matthias Kaehlcke <mka@chromium.org>
CC:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-security-module@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_2/3=5D_LoadPin=3A_Enable_l?= =?US-ASCII?Q?oading_from_trusted_dm-verity_devices?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Yn6IDNgG+/ySOdmy@redhat.com>
References: <20220504195419.1143099-1-mka@chromium.org> <20220504125404.v3.2.I01c67af41d2f6525c6d023101671d7339a9bc8b5@changeid> <Yn6IDNgG+/ySOdmy@redhat.com>
Message-ID: <56E309F0-C641-4E1C-9C7F-52198C43731E@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On May 13, 2022 9:32:12 AM PDT, Mike Snitzer <snitzer@redhat=2Ecom> wrote:
>On Wed, May 04 2022 at  3:54P -0400,
>Matthias Kaehlcke <mka@chromium=2Eorg> wrote:
>
>> Extend LoadPin to allow loading of kernel files from trusted dm-verity =
[1]
>> devices=2E
>>=20
>> This change adds the concept of trusted verity devices to LoadPin=2E Lo=
adPin
>> maintains a list of root digests of verity devices it considers trusted=
=2E
>> Userspace can populate this list through an ioctl on the new LoadPin
>> securityfs entry 'dm-verity'=2E The ioctl receives a file descriptor of
>> a file with verity digests as parameter=2E Verity reads the digests fro=
m
>> this file after confirming that the file is located on the pinned root=
=2E
>> The list of trusted digests can only be set up once, which is typically
>> done at boot time=2E
>>=20
>> When a kernel file is read LoadPin first checks (as usual) whether the =
file
>> is located on the pinned root, if so the file can be loaded=2E Otherwis=
e, if
>> the verity extension is enabled, LoadPin determines whether the file is
>> located on a verity backed device and whether the root digest of that
>> device is in the list of trusted digests=2E The file can be loaded if t=
he
>> verity device has a trusted root digest=2E
>>=20
>> Background:
>>=20
>> As of now LoadPin restricts loading of kernel files to a single pinned
>> filesystem, typically the rootfs=2E This works for many systems, howeve=
r it
>> can result in a bloated rootfs (and OTA updates) on platforms where
>> multiple boards with different hardware configurations use the same roo=
tfs
>> image=2E Especially when 'optional' files are large it may be preferabl=
e to
>> download/install them only when they are actually needed by a given boa=
rd=2E
>> Chrome OS uses Downloadable Content (DLC) [2] to deploy certain 'packag=
es'
>> at runtime=2E As an example a DLC package could contain firmware for a
>> peripheral that is not present on all boards=2E DLCs use dm-verity to v=
erify
>> the integrity of the DLC content=2E
>>=20
>> [1] https://www=2Ekernel=2Eorg/doc/html/latest/admin-guide/device-mappe=
r/verity=2Ehtml
>> [2] https://chromium=2Egooglesource=2Ecom/chromiumos/platform2/+/HEAD/d=
lcservice/docs/developer=2Emd
>>=20
>> Signed-off-by: Matthias Kaehlcke <mka@chromium=2Eorg>
>> ---
>>=20
>> Changes in v3:
>> - added securityfs for LoadPin (currently only populated when
>>   CONFIG_SECURITY_LOADPIN_VERITY=3Dy)
>> - added uapi include for LoadPin
>> - changed the interface for setting up the list of trusted
>>   digests from sysctl to ioctl on securityfs entry
>> - added stub for loadpin_is_fs_trusted() to be used
>>   CONFIG_SECURITY_LOADPIN_VERITY is not select
>> - depend on CONFIG_SECURITYFS instead of CONFIG_SYSTCL
>> - updated Kconfig help
>> - minor changes in read_trusted_verity_root_digests()
>> - updated commit message
>>=20
>> Changes in v2:
>> - userspace now passes the path of the file with the verity digests
>>   via systcl, instead of the digests themselves
>> - renamed sysctl file to 'trusted_verity_root_digests_path'
>> - have CONFIG_SECURITY_LOADPIN_VERITY depend on CONFIG_SYSCTL
>> - updated Kconfig doc
>> - updated commit message
>>=20
>>  include/uapi/linux/loadpin=2Eh |  19 ++++
>>  security/loadpin/Kconfig     |  16 +++
>>  security/loadpin/loadpin=2Ec   | 184 +++++++++++++++++++++++++++++++++=
+-
>>  3 files changed, 218 insertions(+), 1 deletion(-)
>>  create mode 100644 include/uapi/linux/loadpin=2Eh
>
>I would certainly need some Reviewed-by:s from security and/or loadpin
>experts if I were to pick this patch up=2E

Alternatively, since it's mostly touching loadpin, I can carry it in my tr=
ee, as long as you've Acked the dm bits=2E :)

>Did you see the issues the kernel test robot emailed about?
>
>You'd do well to fix those issues up when submitting another revision
>of this patchset=2E

Agreed=2E


--=20
Kees Cook
