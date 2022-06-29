Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAEC55FBFA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbiF2J21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiF2J2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:28:25 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567BF12AED;
        Wed, 29 Jun 2022 02:28:23 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n10so13609991plp.0;
        Wed, 29 Jun 2022 02:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D6P77Nb/YbawwIm3hpXjs2Re4qbthUUy7Msbdx4IPR8=;
        b=UDP+1rNWpOFkS12rXY8l3OX6nTR3jZCLJPcVP44T7OtbPmzYNJhDWSbCMhIFjDTq2Z
         OkcvFhijQIG8iRV2J2ji9BTJhuAWVinSA4QRug00dLgc97gvC5v++aiiR/Ghn3rWbksJ
         6FjLTMaipDXDrk3YT6OaSTvixnHTlefZdNB3Mu4UbJ8sV+VmYyrsSAYEJQbav7Bl/9BD
         gRQBsj9Jr+wFsP1B/G8i0NxEJ/eotq9MFAzJeIvf4OZDbj0GudhKBqJTpmnrpboCPm+a
         5IFEnoUlVjgjxbZBok36xQW8cjeL3Aio6gued2QbFWRMUuPbbrNQdzbBHU9QFpYzCifZ
         YvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D6P77Nb/YbawwIm3hpXjs2Re4qbthUUy7Msbdx4IPR8=;
        b=6bDjuc8XdhSHvKfMRO+4smEfSDBU0z5Ds2Un5d1Z+ANHjdEJBML71JstqGQFGrw2q/
         xNR93ZFQneDOeQtQVaZnHkW1VuEjbZ1ICgiyG9kZXV4ac0/CH2W0GwO7SIuKE4XgctG0
         inrP/2hevWQGZNRudRalj/Rx81VuHmBw8rFNptrWOuigW7QGxOKZocxx+7XiQgGWX5/1
         lF/8plpfUzqipYZFuhQOuwKZUmn0gY7uM6R3qCpMMZVH6XQ1/al+5WdbcHvPr4n70D08
         KCANqvJER66dW3vI0hMaIHy6MHdYk2mFCD6fq4CRCbyuZQMFlVJA1EMxf/QsLIIkporM
         k9Cw==
X-Gm-Message-State: AJIora/QfaSgImPekUBhKXuAEEgDbLtSLO6qMvVwIqUlyWY3StadV9pT
        ImQLU1qu4r26Hv1x2/3dW78=
X-Google-Smtp-Source: AGRyM1sRBNS1WZC2bUurHQUlay9oa5ZNb5VtdIELRQQQj55jvT+jvWV9BkUpP0NdjeRcXHf5M6jU5A==
X-Received: by 2002:a17:90a:1b08:b0:1ec:91a3:532b with SMTP id q8-20020a17090a1b0800b001ec91a3532bmr4878465pjq.160.1656494902955;
        Wed, 29 Jun 2022 02:28:22 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-17.three.co.id. [180.214.232.17])
        by smtp.gmail.com with ESMTPSA id c9-20020a170903234900b0016a10e0ce17sm470772plh.151.2022.06.29.02.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 02:28:22 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A44C21038EF; Wed, 29 Jun 2022 16:28:18 +0700 (WIB)
Date:   Wed, 29 Jun 2022 16:28:18 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, mhiramat@kernel.org,
        zanussi@kernel.org, linux-kernel@vger.kernel.org,
        chensong_2000@189.cn, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v14 4/4] Documentation: trace/objtrace: Add documentation
 for objtrace
Message-ID: <YrwbMu9f7cGosYCT@debian.me>
References: <20220628145552.349839-1-xiehuan09@gmail.com>
 <20220628145552.349839-5-xiehuan09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220628145552.349839-5-xiehuan09@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 10:55:52PM +0800, Jeff Xie wrote:
> Add documentation explaining how to use objtrace trigger to get the value
> of the object.
> 

Looks OK, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
