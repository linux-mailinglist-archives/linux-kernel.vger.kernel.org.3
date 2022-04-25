Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3796F50D7CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 05:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240853AbiDYDq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 23:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240916AbiDYDqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 23:46:03 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A9229CB2;
        Sun, 24 Apr 2022 20:42:25 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id g9so12318604pgc.10;
        Sun, 24 Apr 2022 20:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zxBn91rD5NsN+ULE3f1MzjrrPmMEdVQzDsirY+3w7kk=;
        b=Bv9YRe2DobLRH6V6NLIkIwohK0wEB3NgdyeGivI3/PHxuApWmwSkIL1JObFqchi+Q9
         laLBACYhpjl6Dqi49ln4/AxWiRbhgSnWkRXI74FG+NaCDIDKixJOaPRrCpaTf0fvqHMs
         ciQx/AnGHixBP96lSfl1Nb47N9YpF9iaQQB575vVQtZdCa0PhvOKGfB6lETHLv1Ru9cw
         ejgow6Vf6BkvTHJD3SpjtQVh0tN82elMHdycYBi2wUz/Zqzlyc6qRutfuIkP/PKafruu
         g5T9GlyiRYLKAbVZCGtE0RoAxzl42amqJq7WscEY7G2BpVFJD6IiBcGv+c8QE0zr9IE0
         +/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zxBn91rD5NsN+ULE3f1MzjrrPmMEdVQzDsirY+3w7kk=;
        b=A+MpLebewlitU1IdFpWEfgWJ5pW3GblZU7QjSGDlKp7ENEH5RY3e8XypkorjTQRx0g
         CDOyYqLG2SCBvnt+yXeFlQipUBvenmEDGF5nhmYrbJ4bB5Pk9h1fj0eYjCgF+L7PjDj5
         hXfahlh0sT2pbaHAkpR/6WVmTqW2k9+IJaBY0MjEtjubSf5s4383nygGu9TlZnYxbJL5
         v93Acew1haofpll09LF5pJNOkQFhnI6DA/1p2MO8vjA330iV9Km8ixcsk7FnLKCKfDRs
         4NOA9RqCWtSYbdZ8Mb1AYqgRmpk0fAQ8hxImmk2R5728EYGOpolw5Y26Tb+AqtJlgCzj
         4srw==
X-Gm-Message-State: AOAM532u4em9NanLNayQVHpLm7PzBYps+L3s2TfeE60tQulcvdi4WBfA
        co6GVxe891+Gq8Omt/Slf3A=
X-Google-Smtp-Source: ABdhPJxKAcyR3oTaEZRQCMKouRShYJNrjazsPLwZeuJxY32fcoS3VNvik5Wi3eUWkWzEVUckR4G8Lw==
X-Received: by 2002:a65:6946:0:b0:39d:a0c3:71f with SMTP id w6-20020a656946000000b0039da0c3071fmr13344951pgq.160.1650858144813;
        Sun, 24 Apr 2022 20:42:24 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:282a:d50e:e0fc:c145])
        by smtp.gmail.com with ESMTPSA id i1-20020a17090a650100b001cd8e9ea22asm13013984pjj.52.2022.04.24.20.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 20:42:23 -0700 (PDT)
Date:   Sun, 24 Apr 2022 20:42:20 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 2/3] Input: sun4i-lradc-keys: Add optional clock/reset
 support
Message-ID: <YmYYnOgLhbB2CdrN@google.com>
References: <20220414002349.24332-1-samuel@sholland.org>
 <20220414002349.24332-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414002349.24332-2-samuel@sholland.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 07:23:47PM -0500, Samuel Holland wrote:
> Until the R329, the LRADC hardware was always active. Now it requires
> enabling a clock gate and deasserting a reset line. Add support for this
> variant of the hardware.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied, thank you.

-- 
Dmitry
