Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E19545510
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344809AbiFIThB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbiFITg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:36:56 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94F31D8;
        Thu,  9 Jun 2022 12:36:54 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id n10so49480242ejk.5;
        Thu, 09 Jun 2022 12:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WmtueT3ufRRv1jgkM4LImOdDwQ5tPGE6m6fXDK9beFU=;
        b=fl/n3USbN3m8QqF4I2DkH9aeKJmQlVrqiuJ4kGZdS+1ZBNms8wWqvHLSn+9D9hn4EV
         EcSpSch8B6AYIDM27uhSrBP7n9Ym0n+B8ckGjQuknoG8T82W4iG+v8wLilOVj2et13lV
         m5sWKzLnH8fmEFMQQYbzVIRjAJeV2jwfVM0LgtCuUdSVSYVZ93SA2aRQ073vvSxo8Fck
         g686qK5ukGANV9lrRw9q3gFpxQQLUqLqVjx1zH3rfzMnagrGJxiXsoN9IoGsLfiKTucM
         pbbxIc9DLPoONSpNqd/T6RoxY3BVTTa8JEHg+KlUYuJ+BXhOjnO30RxFV82Q5XOeFALr
         JUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WmtueT3ufRRv1jgkM4LImOdDwQ5tPGE6m6fXDK9beFU=;
        b=yVq3KIHakUGhRWibU1VBQQ0RDEqJslwMA4HXCVsDfxVuibUwA3Fg61I5Z2hQCQaLOF
         qD6hmFez14FVVixOFuRAsM5otBx7LUBH/woY6TNQRRTt273QZ+KMUN3FY/Aw7YpiNqT+
         N8eS2qhW3AZKFJovxRF1pYkDhcNVV4yMIAIhRnuJzYHtB7VATXbHaHax+WJOPDxiampS
         h3mAY3d+QwbNIeVJ9YkRV5jnIIS9l/68EPW6C1aRpz1Yao2LbKe45Aw8zsiYC9ySNyA8
         nguIG70uVwhfHyrKIIzGpoxqR1SZV0YWA5J8BI/RK15y/Oa3c8kaay95c3pF0lb6i4aB
         Eulg==
X-Gm-Message-State: AOAM532MVd3Gs1Trr5F76y9LPkfdtgvYpGwbJC1TbSeti9hgNCyEEotg
        EHCTlGe4K8ccmpAwlFgP/HY=
X-Google-Smtp-Source: ABdhPJzN+Y5oXVq1Jqxbl5cm2ADEYd5ybCUxmmChrZ0KG+m+PVF+sXe+wWivwW/hOeouXwoDWHQKoQ==
X-Received: by 2002:a17:907:e92:b0:711:9fe4:b226 with SMTP id ho18-20020a1709070e9200b007119fe4b226mr23940944ejc.88.1654803413210;
        Thu, 09 Jun 2022 12:36:53 -0700 (PDT)
Received: from DESKTOP-A98GP49 (cable-178-148-254-8.dynamic.sbb.rs. [178.148.254.8])
        by smtp.gmail.com with ESMTPSA id m9-20020a170906580900b006feb7b1379dsm10997704ejq.181.2022.06.09.12.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 12:36:52 -0700 (PDT)
Date:   Thu, 9 Jun 2022 21:36:50 +0200
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Move device-specific data
 into struct aqc_data
Message-ID: <YqJL0lc0/u55woBQ@DESKTOP-A98GP49>
References: <20220609192827.GA2167717@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609192827.GA2167717@roeck-us.net>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 12:28:27PM -0700, Guenter Roeck wrote:
> On Thu, Jun 09, 2022 at 08:59:35PM +0200, Aleksa Savic wrote:
> > As preparation for adding support for more devices in upcoming patches,
> > move device-specific data, such as number of fans, temperature sensors,
> > register offsets etc. to struct aqc_data. This is made possible by
> > the fact that the supported Aquacomputer devices share the same layouts
> > of sensor substructures. This allows aqc_raw_event() and others to stay
> > general and not be cluttered with similar loops for each device.
> > 
> 
> This is doing way more than that; it removes a lot of defines and
> replaces them with constants, making it all but impossible to reliably
> review the patch. That alone makes it unacceptable. On top of that,
> I am not going to participate in a "thou shall use defines" vs.
> "thou shall use raw constants" editing war. The driver uses defines
> for constants. Keep using them.
> 
> Guenter

Understood, thanks :). Will rework it in v2.

Aleksa
