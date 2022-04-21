Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC6150AA06
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiDUUhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392392AbiDUUhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:37:34 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CB64AE37;
        Thu, 21 Apr 2022 13:34:43 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d15so6275638pll.10;
        Thu, 21 Apr 2022 13:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G4IR1S+2VnwD7ZwrNOGPf8P9V36/go7S4VZyJGUy/Eg=;
        b=BeBm2eCz8cCv5EEwO12oLBJh46F9ARV+D9fbWF0OpKzAlZ2f9Cqn1mlMW0Q+hqt1si
         SNwqiVkEcfOlrK5XuSyNB6WwgLvoYWjzyzSB1Cj+1QyZZUBhq5r48tYzxK5JC52cCC3/
         ajIkbwxhpssuY+ODp6aFA+bKiKHDBWWX2Gp9I/8LIsjU3iPgPRL9WQSjqdQZWqm5OWhs
         IpBqsF2uHR/6eeapencgOESAi9gjjtGdJdnIUFyFQWpxgP0oDVygH0jscEMiHW97DGoL
         NBMS+PaSdFRiQn0bVqbDm6/3e2ALxpSdOWopem8ZJWwzLhpRDDKjjzHgoYSKBw1koicA
         schg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=G4IR1S+2VnwD7ZwrNOGPf8P9V36/go7S4VZyJGUy/Eg=;
        b=In2kEV/Ev+wyopVUQG4vSarAaeE3bNmaX9+ardSo7aCQ+trJ/2azamGwjLE8qusb/b
         5o0w0Br+VqAnKI/jTIeyrLaX6RXO0N6lHZFWBP5n06wr+WIz70NQXkdfgnZMFnt/egGV
         7/4t2jKEdAzvKDa6jgBvisuwY/AUZ6NcWEempAgB31JcYKZ+j70PDsLpDrZcTlA4jE5e
         15gg4R6TuT3VeCG9b/lCAWbfopy2DOp1dYJwp8S7X6VZtFk9jQ1zvlsOSXS3Dp6hpqbN
         36nKi5OXS7vc8FPblCELpUx/A6MQE0TOxoe9GkUhuxHyAKNfo7vvc4QlnvsIioUt6Xf5
         wD8Q==
X-Gm-Message-State: AOAM530je/JDZiZmy+vb0Z0GGeUUh8x3FF+AamA56nJ4JxFwtaLSSlD6
        FIHHX5wqzIIKGXLx2i4ObIM=
X-Google-Smtp-Source: ABdhPJxtMvhIb2TjDzKuAYMD44ZqmSeED73RT8ANu1mxwafrsnuy9aQ+rPJG550seXXJi/jenUB82w==
X-Received: by 2002:a17:902:ab96:b0:159:1ff:4ea0 with SMTP id f22-20020a170902ab9600b0015901ff4ea0mr1272731plr.60.1650573283231;
        Thu, 21 Apr 2022 13:34:43 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:2c86])
        by smtp.gmail.com with ESMTPSA id z7-20020a056a00240700b004e1cde37bc1sm25720846pfh.84.2022.04.21.13.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 13:34:42 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 21 Apr 2022 10:34:41 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     daniel@ffwll.ch,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>, hridya@google.com,
        christian.koenig@amd.com, jstultz@google.com, tkjos@android.com,
        cmllamas@google.com, surenb@google.com, kaleshsingh@google.com,
        Kenny.Ho@amd.com, mkoutny@suse.com, skhan@linuxfoundation.org,
        kernel-team@android.com, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v5 1/6] gpu: rfc: Proposal for a GPU cgroup controller
Message-ID: <YmG/4Q0Cz0yUMbu+@slm.duckdns.org>
References: <20220420235228.2767816-1-tjmercier@google.com>
 <20220420235228.2767816-2-tjmercier@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420235228.2767816-2-tjmercier@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Apr 20, 2022 at 11:52:19PM +0000, T.J. Mercier wrote:
> From: Hridya Valsaraju <hridya@google.com>
> 
> This patch adds a proposal for a new GPU cgroup controller for
> accounting/limiting GPU and GPU-related memory allocations.
> The proposed controller is based on the DRM cgroup controller[1] and
> follows the design of the RDMA cgroup controller.
> 
> The new cgroup controller would:
> * Allow setting per-device limits on the total size of buffers
>   allocated by device within a cgroup.
> * Expose a per-device/allocator breakdown of the buffers charged to a
>   cgroup.
> 
> The prototype in the following patches is only for memory accounting
> using the GPU cgroup controller and does not implement limit setting.
> 
> [1]: https://lore.kernel.org/amd-gfx/20210126214626.16260-1-brian.welty@intel.com/
> 
> Signed-off-by: Hridya Valsaraju <hridya@google.com>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>

Looks straight-forward enough from cgroup side. Are gpu folks generally
happy? David, Daniel, Kenny, what are your thoughts?

>  Documentation/gpu/rfc/gpu-cgroup.rst | 190 +++++++++++++++++++++++++++

Can you fold the important part into cgroup-v2.rst and maybe make the rest
code comments if necessary?

Thanks.

-- 
tejun
