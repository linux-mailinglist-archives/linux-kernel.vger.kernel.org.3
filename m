Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253C84C72CB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiB1R24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbiB1R1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:27:54 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D248933A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:27:04 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id q8-20020a17090a178800b001bc299b8de1so11966927pja.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B90OuQ7zc9yVKMEVZCKsWsT7ET8T63FPfntMYlVMILY=;
        b=OHhVJJKi3QwRpjML07uhDBNGsvJriFhT/RPMNynKmU4RJBp/81c6vzb15LhS1kWkPj
         jo7cxjR99E+MYr9GCsHkC3s2CoZMo6nkTKEzCrwRcYY0CzUZHrTZoIHYqXSedkRSofWQ
         OS5sBzh+9rWrBkg123djnzM+6EgcUNzXR+sXy+z3n3C6heOIiIsvSJRft2QbEN58uMod
         EL/QrlaOqlOeCaXnuO+CAzqi5+DOwovRrLu3RmqBI0SKyl+hkGX3z/9bGHC2QJ6TEodk
         wTXY/UUi9eD4FzxBQ8XNa1W84p5V98V9fHnYDpV6PoW1CPSn2zIGty4PJi1Mn0TQzOOB
         fIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B90OuQ7zc9yVKMEVZCKsWsT7ET8T63FPfntMYlVMILY=;
        b=7l2itFgcpd9vnA7sWgpxtZItwd/lkWTEkx8vIWxAL/KDmzOm3D0HrB4wD5e6q4iBc5
         av2YYg6W+6tqmPXbatuuO7uZFc/p1QvuPpCrazkXOZLerrhWmmUDT+AQd1izjxQLSOv2
         PehdfEKEta2NnDg7OhOpZ0DR3XZ/dTL9g/QwgI0Vpsm0RFV7GHy0A5bincgTl4Oa/Fvl
         PabVookIKwdhoLZTZhFl0vCY9OiTLchtxnhgjOuKkfsuoWMG4lnykR+dhttzJFguGui6
         aysLS5ETvCEwZIEtD0icnTT5cSTXi/V/umubUWCdVujg6RcSqQcD8GvGDYIffPykdjFa
         KLbg==
X-Gm-Message-State: AOAM533OKcNNHR+jFPP9i5vk9GIAbKq2NRvKmQ05+Mk/nBjIR2+7j0KZ
        rGhsAT0olisBwlD9fT9Vfrg=
X-Google-Smtp-Source: ABdhPJx/iNMGqljFhakgfTxdO/FncHSNaIeQEtLUil2wMfsLA+k8LTnvxhl5MvsK3lr/JpWx/ON0Ig==
X-Received: by 2002:a17:90b:3693:b0:1bc:89f0:e38f with SMTP id mj19-20020a17090b369300b001bc89f0e38fmr17950554pjb.171.1646069223201;
        Mon, 28 Feb 2022 09:27:03 -0800 (PST)
Received: from localhost.localdomain ([103.172.183.185])
        by smtp.gmail.com with ESMTPSA id f15-20020a056a0022cf00b004f3b99a6c43sm14027748pfj.219.2022.02.28.09.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 09:27:02 -0800 (PST)
From:   youling257 <youling257@gmail.com>
To:     qiang.yu@amd.com
Cc:     pmenzel@molgen.mpg.de, christian.koenig@amd.com,
        alexander.deucher@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/amdgpu: check vm ready by amdgpu_vm->evicting flag
Date:   Tue,  1 Mar 2022 01:26:51 +0800
Message-Id: <20220228172651.12642-1-youling257@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222024651.36675-1-qiang.yu@amd.com>
References: <20220222024651.36675-1-qiang.yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch cause suspend to disk resume amdgpu hang,  [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout, signaled seq=8330, emitted seq=8332

https://gitlab.freedesktop.org/drm/amd/-/issues/1915
