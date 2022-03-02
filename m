Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7264C9B45
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 03:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239012AbiCBCkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbiCBCkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:40:04 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8F92E6AC;
        Tue,  1 Mar 2022 18:39:21 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id e13so367388plh.3;
        Tue, 01 Mar 2022 18:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:reply-to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=MtG6z1Jzb89Ndx+jl2cJ0c1G9ZcfiK5kSL2+E0wyCng=;
        b=abfrrGS0XqDXsi7/Xv1Z4tFdV23VfDvlIsqmd4l95dfY7OUh5ZJyiuhIRJ+mFzXvXu
         BKuNxZymZZ+9o/qz+/P4mWxNDsggFyiMKX9WtNN7DeEQAKwvM901P5x8q3wV8kNYLzkC
         ekKEg4poMrbv+9f1tv0+/PTTgnPje9Q6ZLayL35dxtzSpccu9hVxCZ9d0GR8W+obk+2r
         LNLscVM1qONrJG5A8GlomyUwB/1rq/J2qNKuoIchtJ9lmd1ltbb3DwQSMsLB5bZWmPQx
         LkyEdp3dmN7LMztvoMwS2oBTz7Y6jn3zQw2dW83nmUeoTXQwIoLDYtszH8OMTyifNlws
         5A4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:reply-to:from:subject:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=MtG6z1Jzb89Ndx+jl2cJ0c1G9ZcfiK5kSL2+E0wyCng=;
        b=FNQsFE78dj6w4qyXA+4TIzjQ5h8C0960JjVmkNZgdyvbSfMbjw6pCxX7k9T7ATEOF+
         Qds36ERxnZX17yy+TTJMwLvPEW1GYzYJ/5M9ZY2n8n1HaENNIcsZJvY8eTMiWdkG7GVC
         xvR1qoQeUaq8gT1Rmz7EvbaGyjCXNcoNWuS9eRmbNR69EWMIw8QD2yA2mJQhOGx+kd/q
         fgSiB3NXERqrqek5oQfrx/3qkqug4HYOZR835KGHmSe8r3NSTYRwfxWNJLkE3/lMTTxE
         25Vs08NBlSiVvBUAL66wlSbv3yIAxW5HTXVw5Neinfvo4KSYUI4RKWGINQi/z44ElVv1
         BB7Q==
X-Gm-Message-State: AOAM533RA9ZskRw4XN1qA3O2QNAuaK/eKRetKfr38xoZJgksus4rB9Lo
        6hCJBbhgyqy5I2HFheFWHQA=
X-Google-Smtp-Source: ABdhPJzRWPFocHCjcn3D/1crvW6jIAuiApm7zY8OeyhMDlDQKmtpOisKmOaARpeA6aFKmOW7Zn/Ufw==
X-Received: by 2002:a17:902:e549:b0:150:2412:c94c with SMTP id n9-20020a170902e54900b001502412c94cmr25176748plf.94.1646188760970;
        Tue, 01 Mar 2022 18:39:20 -0800 (PST)
Received: from ?IPv6:2600:8802:2207:ac00:38b7:6dcb:b27d:e974? ([2600:8802:2207:ac00:38b7:6dcb:b27d:e974])
        by smtp.gmail.com with ESMTPSA id z6-20020a056a00240600b004e17ab23340sm18875337pfh.177.2022.03.01.18.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 18:39:20 -0800 (PST)
To:     dri-devel@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Lyude Paul <lyude@redhat.com>, ville.syrjala@linux.intel.com,
        jani.nikula@intel.com, airlied@redhat.com, dianders@chromium.org,
        tzimmermann@suse.de, sfr@canb.auug.org.au,
        lkft-triage@lists.linaro.org
Reply-To: CA+G9fYu4PPE6_91mzor0bW7RSzBDNJ3xqqgeeK-jR1jokmhYOQ@mail.gmail.com
From:   Rudraksha Gupta <guptarud@gmail.com>
Subject: MSM8960: gpu/drm/dp/drm_dp.c:59:27: warning: array subscript 10 is
 outside, array bounds of 'const u8[6]'
Message-ID: <8e13f51a-845b-1fdf-11ea-6053f7d8df9e@gmail.com>
Date:   Tue, 1 Mar 2022 18:39:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,


I am getting this warning when compiling the kernel for the MSM8960 with 
this defconfig: 
https://raw.githubusercontent.com/apq8064-mainline/linux/qcom-apq8064-next/arch/arm/configs/qcom_apq8064_defconfig


Warning:

../drivers/gpu/drm/dp/drm_dp.c: In function 
'drm_dp_get_adjust_request_post_cursor':
../drivers/gpu/drm/dp/drm_dp.c:59:27: warning: array subscript 10 is 
outside array bounds of 'const u8[6]' {aka 'const unsigned char[6]'} 
[-Warray-bounds]
    59 |         return link_status[r - DP_LANE0_1_STATUS];
       |                ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
../drivers/gpu/drm/dp/drm_dp.c:210:51: note: while referencing 'link_status'
   210 | u8 drm_dp_get_adjust_request_post_cursor(const u8 
link_status[DP_LINK_STATUS_SIZE],
       | ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

