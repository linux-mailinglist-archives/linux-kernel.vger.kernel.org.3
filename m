Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A88525708
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358716AbiELVa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343679AbiELVaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:30:20 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AFD1A15FD
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:30:19 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id l11so5688955pgt.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=BIPrJxqbXAd+295s29/rrMW5CvpwBx6wdUxINV63DAg=;
        b=Zg5truXSUHQKziPjOTc4E2O6KDJH+6qHbxL+9Law57qzVH6SVKpT2voeDHzzyvzj5b
         uggFLFxEqgtXYEb9pQplsYNKt0VUIvBSB/e/jlS+B4YlmJCuXVMoilgQjYogEfO1ShEk
         8oRI17+p6b147utmqg5HMg+CqdgII9RBkSRNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=BIPrJxqbXAd+295s29/rrMW5CvpwBx6wdUxINV63DAg=;
        b=zOa/vGJc+/wFxX6apHW+1feF3Dl5w59quZS+8KSZe3i+s0xM1xalgMhqY4AtnMWCJK
         KsdHmMYYKA8QwZbNUENWiFapOdz2T45elBp/caXpP4RGuUAV7LksKN6ILmYJYzssu4Cm
         Tq/HhDUs6H8MqHVMEQJx9jpXJAXlHdTRaZYO9pmD7Q7pGxKaMugTw9aIZ15MiIswM/EZ
         5zfvwyvPLz1MKrTNTyBBR/1ZJKt0nAYIwDSmZIfM71EMmDiszVJFGTf3VIxd97BMdOWV
         6BKV+0Gnx9wLJo/eA2xlf5TDlb5FCAkYBr2z0NRkYtCb5QTKyil2cK8lk+alRDJaKbM0
         3tEA==
X-Gm-Message-State: AOAM5318RQJdg/JqYuSR+ZgARzX0r4PP4cot8Tosf8q4mi1oD08l+NpT
        bX9DYpQAkQ6CSUNpElBIZFyyeQ==
X-Google-Smtp-Source: ABdhPJzDDlG5ka/o2WcllRfswJSM7NjDXKFvt55zHZ+GNjiCVBiiEna26O0pZFz3O+Zji3jW2c7Ibw==
X-Received: by 2002:a05:6a00:c8f:b0:510:60cf:55fa with SMTP id a15-20020a056a000c8f00b0051060cf55famr1314141pfv.37.1652391019468;
        Thu, 12 May 2022 14:30:19 -0700 (PDT)
Received: from [127.0.0.1] (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902edd000b0015f3d8759e4sm350899plk.167.2022.05.12.14.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 14:30:19 -0700 (PDT)
Date:   Thu, 12 May 2022 14:30:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
CC:     Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] drm/i915: Fix CFI violation with show_dynamic_id()
User-Agent: K-9 Mail for Android
In-Reply-To: <20220512211704.3158759-1-nathan@kernel.org>
References: <20220512211704.3158759-1-nathan@kernel.org>
Message-ID: <DEB6A9AC-845E-4656-A596-E6341D3C287F@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On May 12, 2022 2:17:04 PM PDT, Nathan Chancellor <nathan@kernel=2Eorg> wr=
ote:
>When an attribute group is created with sysfs_create_group(), the
>->sysfs_ops() callback is set to kobj_sysfs_ops, which sets the ->show()
>callback to kobj_attr_show()=2E kobj_attr_show() uses container_of() to
>get the ->show() callback from the attribute it was passed, meaning the
>->show() callback needs to be the same type as the ->show() callback in
>'struct kobj_attribute'=2E
>
>However, show_dynamic_id() has the type of the ->show() callback in
>'struct device_attribute', which causes a CFI violation when opening the
>'id' sysfs node under drm/card0/metrics=2E This happens to work because
>the layout of 'struct kobj_attribute' and 'struct device_attribute' are
>the same, so the container_of() cast happens to allow the ->show()
>callback to still work=2E
>
>Change the type of show_dynamic_id() to match the ->show() callback in
>'struct kobj_attributes' and update the type of sysfs_metric_id to
>match, which resolves the CFI violation=2E
>
>Fixes: f89823c21224 ("drm/i915/perf: Implement I915_PERF_ADD/REMOVE_CONFI=
G interface")
>Signed-off-by: Nathan Chancellor <nathan@kernel=2Eorg>

This matches my own investigation into the error=2E Thanks for putting the=
 patch together! :)

Reviewed-by: Kees Cook <keescook@chromium=2Eorg>


--=20
Kees Cook
