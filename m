Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071275B2C04
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 04:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiIICQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 22:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiIICQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 22:16:34 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CE215A17;
        Thu,  8 Sep 2022 19:16:18 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b144so301596pfb.7;
        Thu, 08 Sep 2022 19:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=Gx7ty68QJbjRvABlL7dZhQBkVJL/GAkDyuAv8JW9Eho=;
        b=CUjM/9ohviiGVgEaxlBsgL4OBVz0/u1WIJOuGX40o0qFrtaUGRJPZfGVWUos3T7EF6
         rdwwifXsrYEccZYi519bEOtaT45ofZ3muAFXdZNu/3dnfPgM7PFFG5aOvxec4RHLxOeX
         B0yS41Z+xyPdriq4M/rn0uHavKtfqbLQmtsFMALrz3yxY6MhjOrTHt7JmIc4j1gS+JWr
         doTkAJp+/LYtmQxNlP7FAonVLvk/J3QmcSLhmbaxk3COzCWL4Af4Z1FGdQXT4QjQ6LZ6
         nIH5aHtG5Irld0cPnZec01HQSJDFmMXRFHvs2GBh5jbMfg5WXbKEYEwam6hRYNdupth+
         GlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Gx7ty68QJbjRvABlL7dZhQBkVJL/GAkDyuAv8JW9Eho=;
        b=TqpLY/XL4drO78+s3yoQwwkWweBxw9EnqkQOf+Dr3r1je7SSz5OUNOksseEj9L+dCm
         XuS4NOBSiDq+9gYOl/wFr5Eh5bNgiDfhZ41FXiX26bD0w0/JWdXVQgFCjuxs1Pquk3gm
         m45sV24Owtdeecr9wk8EGhn5R6vVU/RUnKxa6G58zgnmJmpgk0I+xfP+Myr35IMk4LLZ
         wBC8Uli731WeApMJ2ySjEg1g7Vy4//P5QWvliK8hMisq9lnuSD2cfk3TkZLiWpQoSZdu
         Wfdyy+ZOqj37cDpNA3EzM3SU+vZ5NH44hp0tnPSN6hD6IXt+46rJoQKQWN2ng9KasYDZ
         DTLA==
X-Gm-Message-State: ACgBeo2nRbF1gy++4umvhwdMbtpgCjtWtBg5W0ecvxbW7NhumvzZ9gmt
        ZqBO8JmJa14c9CYSHAEj2vo=
X-Google-Smtp-Source: AA6agR4N0zeXYqvpr4NA62I45gNZ+9C+BjkSvD/mtE1KuPxD815ybPGnMni7j0qOdqTd9FWV8m1r9w==
X-Received: by 2002:a63:f847:0:b0:438:1923:7d00 with SMTP id v7-20020a63f847000000b0043819237d00mr4254013pgj.206.1662689777760;
        Thu, 08 Sep 2022 19:16:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z13-20020a655a4d000000b00412a708f38asm165927pgs.35.2022.09.08.19.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 19:16:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 8 Sep 2022 19:16:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, andriy.shevchenko@intel.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com
Subject: Re: [PATCH v5 07/21] dt-bindings: hwmon: (mr75203) add description
 for Moortec's PVT controller
Message-ID: <20220909021615.GA4179140@roeck-us.net>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-8-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908152449.35457-8-farbere@amazon.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 03:24:35PM +0000, Eliav Farber wrote:
> This changes adds a detailed description for the mr75203 controller and
> for some of the analog IPs controlled by it.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>

Applied to hwmon-next, with Rob's Acked-by: from v4.

Guenter
