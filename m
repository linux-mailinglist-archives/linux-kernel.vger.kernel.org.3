Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F114E4591
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239978AbiCVRzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239590AbiCVRzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:55:05 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C98BBE13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:53:37 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so3690808pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3s5gDWos+PtUBLd8/ihqJugKS3ctUwBv/GPhwSs2FSg=;
        b=J0hXkgmwRkfvoxa+/cJHitTUDL4MBLzi6/4VZaaROhoGfxwHEt9opFvvnk30v5W76A
         gSPMZK0GobqR+CVlBi0YKf08GT0gASfjlWZg7jTTZCWi1tsGBEU/boiHzw6vJavQMChW
         3+mm6C1Mus9NgYXuUAHqwUeWZeQpB1++KwRAZeikitNpYgIFbzWHIXyxCh+0By7ZWy0f
         93e0UaB9SSeMHBEV5+/uOc56iHw3Yx5LKftZuTA/67kUZ8gXdr7dZGsPBFP7eH9B/3/e
         VDS5j3NfD+/us8Wi/aSwLJgSNWcWyAjy7Hpc9pFWirXCQPOdPssBmAoiGSMJITWbxPme
         7jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3s5gDWos+PtUBLd8/ihqJugKS3ctUwBv/GPhwSs2FSg=;
        b=0bqF4X+XJY1kICQKfMqA/gAu6Lx3FYD+6jGxdF6ILmRg02LJGVhtJb0K4Y3b4eJ7B8
         evYZ8U76HCM/HQ+th0wppUAKK1YNCVl5o0hzKS3m7omH57Q188DHAhr/T8GSvSWjTyTQ
         8jI26tASATS1RKFAaO7+bfwoYPoeHc8Nan0HM8unEm4REATtek9xuglT5oP3vo3d1aLk
         V4aINVSHVVUAE29lA7UjN0Z0OG2fdDm+aDe+vLGNK3Pk/Qydzf5NfnbzNokUZfkl4FJp
         xWLlBvMF189CDeFclMXkQ9FW4VgFDCQG3x7E+IFfVM9sTh3HYWGI5vXrZ/S6TjHOhODt
         kOwg==
X-Gm-Message-State: AOAM533LxnRlhs6/m7Dbvgd3//IcX3ibtFUHkw0OcG2qflP5L0ps6zZ7
        ar3QRgsgPlQuPHlkUQomz8WqstDCIPZDH0ApK15DOQ==
X-Google-Smtp-Source: ABdhPJyet6bOhKvdAllqdaC/IxzQPS5NrzuBCij/+cPDNReudOSbHOq6XC8Buzc2uf6Zwfci6Gv8/fi7bvkucL9VT0s=
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id
 d22-20020a170902729600b0014b4bc60e81mr19167073pll.132.1647971616906; Tue, 22
 Mar 2022 10:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220307094158.404882-1-wanjiabing@vivo.com>
In-Reply-To: <20220307094158.404882-1-wanjiabing@vivo.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 22 Mar 2022 10:53:29 -0700
Message-ID: <CAPcyv4im7c47C+jrTbQC=FGgCV35ME8vuYA2-KXYRKsdEuOuuQ@mail.gmail.com>
Subject: Re: [PATCH] cxl/core/port: fix NULL but dereferenced coccicheck error
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kael_w@qq.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 1:43 AM Wan Jiabing <wanjiabing@vivo.com> wrote:
>
> Fix the following coccicheck warning:
> ./drivers/cxl/core/port.c:913:21-24: ERROR: port is NULL but dereferenced.
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Thanks, applied.
