Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46234F6608
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiDFQxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238132AbiDFQx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:53:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51294274E7B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649254648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=l/rlayWAz6LIN8DHFEn/JZ+tDFeU/OUyuaiK0vcp1d4=;
        b=e6G65m0XPvSRBL/rCF8GqURdpgmBoah63Msx1fVZvv1O5MQG4ooD5MLbiCMsK5SdnCdeEP
        FRrbZRVF+baX8eepk9x4701YqDGueAni4jLmTbehO9qHvL2Dh9TesO+l0IpU56LZXw6lKb
        laM8V1i3QzvI9LzgnsItNyDQ9LcdVaM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-30YfP4Y9OFePOAkLyjFK9w-1; Wed, 06 Apr 2022 10:17:27 -0400
X-MC-Unique: 30YfP4Y9OFePOAkLyjFK9w-1
Received: by mail-lf1-f71.google.com with SMTP id e15-20020ac24e0f000000b0044a8b775985so886219lfr.19
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 07:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=l/rlayWAz6LIN8DHFEn/JZ+tDFeU/OUyuaiK0vcp1d4=;
        b=M9N9c1MTibcA146Fu2c5UEOGlfGBBDvYb6fOjW33YhYSbm82YmZeyWD4P84C0aeVbC
         7qlid4kSy6+5yxNeQaQo3s3WFutNw4BIk+VDqytkFLtXMEdafzj0q6s9zFf1t3FIm7/M
         DBfyRb4SXEie/vTDF/cMNvLdQ4ikCpJwgFngS2ZlZcTofdQr4w4BLKbeMcsSZxDHHKsL
         30T9BS27KJ8NAW5OESmuYJnpEZiTWorZVl/6meFtp6DNDP89KbQHgdJAc/VsejliHxu3
         l5tAmdk8EeDUggVMBCwzLoYsU/9zsSMOm/kez3NDPwaQs6uzhZCQkD8RuB2eJdTXIRfh
         WOww==
X-Gm-Message-State: AOAM530xAjvz9bVin47lRyDgAHV3cnBgXREZNQjPleQw8bF29iH+8Soz
        CqBrSQyaBNLdNxq1G0x1EKbBhHCPICskp+yoMvI4OOdk0cyP5HMWuJn8TFI/F8zoTZgqh7ykru0
        Trfi7zzvAaVSp2BWc9lWN4AWCvERjC2GkMm93TJzv
X-Received: by 2002:a05:6512:b92:b0:44b:36d:27e0 with SMTP id b18-20020a0565120b9200b0044b036d27e0mr6199615lfv.537.1649254645246;
        Wed, 06 Apr 2022 07:17:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwULjqchBcfxtC/ML8Q9nEv0WuwPD5Jvo5RUPMEfprUIeVSvIf6Th+CwqiwMRk9yvgXvAH43CYwCtwQitBMo/M=
X-Received: by 2002:a05:6512:b92:b0:44b:36d:27e0 with SMTP id
 b18-20020a0565120b9200b0044b036d27e0mr6199560lfv.537.1649254644042; Wed, 06
 Apr 2022 07:17:24 -0700 (PDT)
MIME-Version: 1.0
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Wed, 6 Apr 2022 16:17:13 +0200
Message-ID: <CA+QYu4omi2irqUpDi_3POT8djdgg3q0ZVujdE1jfLPwsTxjB5w@mail.gmail.com>
Subject: =?UTF-8?Q?special=5Finsns=2Eh=3A36=3A9=3A_error=3A_array_subscript_0_is_ou?=
        =?UTF-8?Q?tside_array_bounds_of_=E2=80=98unsigned_int=5B0=5D=E2=80=99_=5B=2DWerror=3Darray=2Db?=
        =?UTF-8?Q?ounds=5D?=
To:     linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Trying to build mainline kernel with gcc12 and selftests we get the
following error:

00:01:22 In function =E2=80=98native_read_cr2=E2=80=99,
00:01:22     inlined from =E2=80=98vmx_vcpu_enter_exit=E2=80=99 at
arch/x86/kvm/vmx/vmx.c:6772:24:
00:01:22 ./arch/x86/include/asm/special_insns.h:36:9: error: array
subscript 0 is outside array bounds of =E2=80=98unsigned int[0]=E2=80=99
[-Werror=3Darray-bounds]
00:01:22    36 |         asm volatile("mov %%cr2,%0\n\t" : "=3Dr" (val)
: __FORCE_ORDER);
00:01:22       |         ^~~
00:01:22 In function =E2=80=98native_read_cr2=E2=80=99,
00:01:22     inlined from =E2=80=98vmx_vcpu_enter_exit=E2=80=99 at
arch/x86/kvm/vmx/vmx.c:6778:19:
00:01:22 ./arch/x86/include/asm/special_insns.h:36:9: error: array
subscript 0 is outside array bounds of =E2=80=98unsigned int[0]=E2=80=99
[-Werror=3Darray-bounds]
00:01:22    36 |         asm volatile("mov %%cr2,%0\n\t" : "=3Dr" (val)
: __FORCE_ORDER);
00:01:22       |         ^~~
00:01:22 cc1: all warnings being treated as errors
00:01:22 make[4]: *** [scripts/Makefile.build:288:
arch/x86/kvm/vmx/vmx.o] Error 1
00:01:22 make[3]: *** [scripts/Makefile.build:550: arch/x86/kvm] Error 2


Full build log:
https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawa=
rehouse-public/2022/04/05/509694021/build_x86_64_redhat:2295283495/build.lo=
g

build config: https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse=
-public/datawarehouse-public/2022/04/05/509694021/build_x86_64_redhat:22952=
83495/kernel-mainline.kernel.org-x86_64-3e732ebf7316ac83e8562db7e64cc68aec3=
90a18.config

Thanks,
Bruno Goncalves

