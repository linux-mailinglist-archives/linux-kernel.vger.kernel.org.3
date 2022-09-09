Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98925B2C08
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 04:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiIICSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 22:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiIICS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 22:18:29 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8F71CFE8;
        Thu,  8 Sep 2022 19:18:16 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so186757pjh.3;
        Thu, 08 Sep 2022 19:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=tWSU9WboQzLTzOa74A8xD0VnMSvyfWZ+8CkIK++Wcmk=;
        b=DArTNULv2j/a1/emrzO0LwxvHyg1lntswONij4t8a8os+YcQO9EaM+0aCFetrf3ZrC
         z0LBF6UDhJ5FTO6DOnq6jVLR+98+mhTcy+WqL9vGzW+b3EfObqSha/GWDemaEutqsaKS
         leLT+AzF06mmgbjgI7CaffTMcSbNoPhp6FkvMamqLQhGE67AeI43gQmbziDm62Sw25X6
         ZiXsfGOoJ6AilChX2Q7myfGGYLwlAOgGdZ00C3hL2o/eMhRGXMTspHQtvuZD8WXGupA6
         ulI42siSVd5ag23YCOLx1EkO6CqIQgeyyrQcZgS794fEbN8Rc9Rtam+LHDoAc/Vla6NM
         04KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tWSU9WboQzLTzOa74A8xD0VnMSvyfWZ+8CkIK++Wcmk=;
        b=nWJmthxztjUHW7ikjYfH4ZJVK1HXQzbm9tUc/KGK483k42jxaiOXshr23DtyEeVN3L
         x+eCUEHFoMM/TzcWgKtRyA6+ie1GHxETecy/b6zw4dVImWut49ZmgHfl2IZxq3OTYmAX
         t8aUJqAnpy5oPyGmKp/n18niEozeWNk4t89MFyaI2TCoBxnwRX/xHzeUXTUcdgIfhICf
         LJ479dzsuoglI+hS1KB5hO2GvrYnruhranhbZd3TN2Jvzhg848FLZdHcCVRWu+Kaa8d+
         XcKcHt5kF+01GIHpQaqJLQp6ofe3p7XJ0T8rz9ou88Vu8uy+GEo7VRaFY5P83M/YA+wo
         SPwQ==
X-Gm-Message-State: ACgBeo36mysl1QZ7Eh2INagheUgD4ZSPQ6e4Ug2NKWcLDq0oEdc5oXGs
        IDuaAFI2q/Vcs0LPNWqZIws=
X-Google-Smtp-Source: AA6agR7u07KE+rvKeboiDefTfGENPeBYYWMSSrkEIxVZYkJ5Dsdi7DlhbyvgMBeBO0XeIUygMb+10A==
X-Received: by 2002:a17:902:c206:b0:176:a575:5ca8 with SMTP id 6-20020a170902c20600b00176a5755ca8mr11816712pll.74.1662689866138;
        Thu, 08 Sep 2022 19:17:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db0200b00176c89243fcsm201317plx.179.2022.09.08.19.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 19:17:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 8 Sep 2022 19:17:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, andriy.shevchenko@intel.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com
Subject: Re: [PATCH v5 08/21] dt-bindings: hwmon: (mr75203) change "resets"
 property to be optional
Message-ID: <20220909021744.GA4179405@roeck-us.net>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-9-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908152449.35457-9-farbere@amazon.com>
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

On Thu, Sep 08, 2022 at 03:24:36PM +0000, Eliav Farber wrote:
> Change "resets" property to be optional instead of required, for SOCs
> that don't support a reset controller.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>

Applied, with Rob's Acked-by: from v4 added.

Guenter
