Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C655C57594B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 03:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbiGOB4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 21:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240987AbiGOB4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 21:56:39 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF5432DBF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 18:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mmLStNRkF6W9seC2izW5SAo9LagXYzdl6jVNyMVhXFs=; b=ek0RSbCy45pDM3TxkSejUNPs/4
        jLvmev/r92eB4fcXsy0EI7Y4gqzX+Bg8S9A1qZrkVKzhpBrBPBkmdR77miLIj+H1OFPpUNJxTODjh
        mjga5gok8197ak/jSXYvawiHwQownqn/NK0j1ZeP3DeJvxVsPOslmlvMY4V11tmJM0kgvubuk+78h
        dKjEnGMgeovRXGQ/3MlEno3uAcyvN7EHxAJ5885zI/5AwdDa/C0NBmesdVLdhNPqmLPRtQvNo9F1P
        ztEEw4qWpcupgO+XZx5faCYUv27fg4eRsPxBTiSX2jBUuJhiAlh1O53B4s07PJyg0hzj1FqwPHFEh
        DyurutLw==;
Received: from [177.139.47.106] (helo=[192.168.15.109])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oCAZB-00H9j4-N7; Fri, 15 Jul 2022 03:56:29 +0200
Message-ID: <086abf6b-60ab-c0f5-e1e5-c39f0c33484c@igalia.com>
Date:   Thu, 14 Jul 2022 22:56:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/12] drm/amdgpu: Write masked value to control register
Content-Language: en-US
To:     =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     magalilemes00@gmail.com, tales.aparecida@gmail.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        mwen@igalia.com, Isabella Basso <isabbasso@riseup.net>,
        andrealmeid@riseup.net
References: <20220714164507.561751-1-mairacanal@riseup.net>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20220714164507.561751-1-mairacanal@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Às 13:44 de 14/07/22, Maíra Canal escreveu:
> On the dce_v6_0 and dce_v8_0 hpd tear down callback, the tmp variable
> should be written into the control register instead of 0.
> 
> Fixes: b00861b9 ("drm/amd/amdgpu: port of DCE v6 to new headers (v3)")
> Fixes: 2285b91c ("drm/amdgpu/dce8: simplify hpd code")
> Signed-off-by: Maíra Canal <mairacanal@riseup.net>

Series is Reviewed-by: André Almeida <andrealmeid@igalia.com>
