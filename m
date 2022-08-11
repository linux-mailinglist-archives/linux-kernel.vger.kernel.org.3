Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F6F5905A3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbiHKRRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbiHKRRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:17:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF932AE9;
        Thu, 11 Aug 2022 10:11:00 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v5so9774869wmj.0;
        Thu, 11 Aug 2022 10:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=9lmCRb9w6uCDtNqUvz+VlG2tKHmhpYW/JN7ZTZ0wmWA=;
        b=HueoZjS09HesHA6TCTd0JPvcBzWU0gb3xP9VW8Z/5Z/IKUTGcxCTFMAG6sdNrMVRPI
         XnrC4DiqsP2rdQJP9mkDCIzGrBusm9Qc0UUy6mvDQvs1Y9D/odTmBhoAqjwVVT1PEP2a
         JhvZLP7Y7ewJiwBLh9bNypUzht0ngPd3zFtQ3sgGLWOI4mqyM3Tb8e7fp8v1GuUb8mnW
         BsIZT+UyxiocbCaiSIIB9NZf9tSMHiXuJipn0qbdhRIgFIWA+K/RWq1NdWpHZCzcCc+J
         J1DEAaHrNGdyKVd4wCP6/y4ZMEMKdBfjcDWQwdB+WVDIpg0wcevdm6XgmJVtTgxQMo0t
         WLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=9lmCRb9w6uCDtNqUvz+VlG2tKHmhpYW/JN7ZTZ0wmWA=;
        b=5bEikKJo0oktgkE3/NnbDwa8v5RvNJkt5w7ybFFH0+FftiafE/zZFRPK5ODysowQxO
         GYn5gDdA9yoLndzffqOJezh8O6u3UtPUoX6GjKuzjJ5jaxsCJ3ZsyNxlw5GuFYw1KAay
         wNSjZ8UmLKMikICZuDwphSspbTo8cKMXoiqS9CzKYrjPCsXdnWltRwcpSz1yJLkum6g7
         39ctZzR6yJd0qEj0yF1LWpzDvehg1p+Ic4Nk7WtUEsXHT1JWu6Ha9PNSXwvbb7XGU0lk
         xAh2ATQ3MkgFKlxx2L5VMFYxP6r4OM4zvX226qDvem8JzcaABLaxK8kgqf9nIKBSUvvN
         c+Qg==
X-Gm-Message-State: ACgBeo22qLvlRgQEtzEKxCiFd7BwHNi+lCfRfnyfbAMDpNlJPYJ6n0yu
        KmhpjoXrP/F4HaqdWKjI1toIvJfQLY0=
X-Google-Smtp-Source: AA6agR68hJQ2kVu941cLF0W2MeedTSh595znTTi1zvBbU1seBZqoyPGDGJiGim5IewA7q2JgPbE7ew==
X-Received: by 2002:a05:600c:4ed0:b0:3a3:3ef3:c8d1 with SMTP id g16-20020a05600c4ed000b003a33ef3c8d1mr6369177wmq.154.1660237859175;
        Thu, 11 Aug 2022 10:10:59 -0700 (PDT)
Received: from debian ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b003a308e9a192sm7647413wms.30.2022.08.11.10.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 10:10:58 -0700 (PDT)
Date:   Thu, 11 Aug 2022 18:10:48 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: build failure of next-20220811 due to b1a63a0b48ad
 ("drm/amd/display: consider DSC pass-through during mode validation")
Message-ID: <YvU4GD8HtZ1A4dhI@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Not sure if it has been reported, builds of riscv, alpha, s390, arm,
arm64, xtensa, mips, csky allmodconfig have failed to build next-20220811
with the error:

ERROR: modpost: "dc_dsc_compute_bandwidth_range" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "dc_dsc_get_policy_for_timing" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

git bisect pointed to b1a63a0b48ad ("drm/amd/display: consider DSC pass-through during mode validation")
And, reverting that commit has fixed the build failure.

I will be happy to test any patch or provide any extra log if needed.


--
Regards
Sudip
