Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFBD5A6EFA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 23:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiH3VPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 17:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiH3VPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:15:11 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8F3DFE6;
        Tue, 30 Aug 2022 14:15:10 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d12so12304658plr.6;
        Tue, 30 Aug 2022 14:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=m/8CrKbaAp1qGMsp5T1xBhJHX7yXjrPm1mj6smU4pgU=;
        b=P0tlImlODw4BbVrdArUTrQcHNGJP/zCE6S1BoCUN8Hw7vB6p/vFK+Y3ckI+v77ohco
         84HA04JVxnAnwFLwDF/8gAoV+FR9Aa3Qx+hEL2rNivcwHHS6tT+ipt91oKVqw5xQqRww
         TqBR7u5C9KRPU84g321vu+ZkqnHEN+eZqlqV9ookOYx6lv1c8A5CoyEH49xdrHMyW++g
         LpbqVD2OqU6sbumzq0CFh9niXsilmjzszvtXi4leYbDM8D3iQ1D1baax/zki06DIeW7L
         J3MkZl3bkam/SsdwbIIdjwKEQkQtHx1NNjhXClj5nY3dPGqOMS0Jv4pbrehJ1Pp/jnpa
         ReWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=m/8CrKbaAp1qGMsp5T1xBhJHX7yXjrPm1mj6smU4pgU=;
        b=sPsKEslZ8evwSwuBvbyz1Sb5bp0N4nwBjviYufphdH7uIs26RJzdA5IRFcxnmtGx2N
         JL6YAFUTlxNv//TUlwEdYybb7XTakUr9xWftaxAkcUXDusUJmMYypiGwEH+i45XkLHeS
         DRFVNyHHaWrfTNDoBedsa3jOBT5uTnDw1eV6WQE4C5TeHjt88A1ZgK9jqFjwW+S7QfqH
         /FMCwxHqP7vxF59qPZHP/29VB7ivQiUj9Kb326OhUSGV5+6x0LRFk+RkW3hoNfarBAqd
         46R2gRMflOK49OjAFrS54t7xXKV2L2vG0ux/AnbySvyp1rtF4XrvRmeyuFD0pNEIjlgl
         CiOA==
X-Gm-Message-State: ACgBeo1s3rT+KrqeA1q4iopXqx6l7UEGPHUPLdkPD1stIt0wp0vWSh6y
        IqtbO1h1gypT7xBvulnLnQg=
X-Google-Smtp-Source: AA6agR40BOFdjNshHRJCiGj+sNqWY1XxSbdkUTlIQ830Y31mDN154qjp0XoVv6XXffNrBMi8yumRhA==
X-Received: by 2002:a17:902:8e88:b0:172:d1f8:efcb with SMTP id bg8-20020a1709028e8800b00172d1f8efcbmr22191892plb.27.1661894109561;
        Tue, 30 Aug 2022 14:15:09 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:2488:79db:897a:5de7])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902e54700b0016d1bee1519sm968591plf.102.2022.08.30.14.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 14:15:06 -0700 (PDT)
Date:   Tue, 30 Aug 2022 14:15:03 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH v1 1/1] Input: clps711x-keypad - get rid of OF_GPIO
 dependency
Message-ID: <Yw5910pp0tUjNBJE@google.com>
References: <20220830182839.47965-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830182839.47965-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 09:28:39PM +0300, Andy Shevchenko wrote:
> There is no such dependency in the driver, but it's implicitly
> used to have OF property APIs available. Replace that by device
> property API and get rid of OF_GPIO dependency.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied, thank you.

-- 
Dmitry
