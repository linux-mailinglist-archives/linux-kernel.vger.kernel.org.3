Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC500568C58
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbiGFPJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiGFPJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:09:12 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFB8E74
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 08:09:11 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id h19so18610981qtp.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 08:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tsz2MOLF2Bl4qmuGvjK22N+/EXyHNeIKMYNiVvkEHV8=;
        b=tBXaKvGZfpb9lZ7mG4pNOl5WZH+peRj/uvZGKMpIbfTM1AzfoUCbmIcECEOPJBuyNF
         7jvHUnUO9/FdPXpqGcCIWvZBb+7TX/HXG/wM33+TndG8lYKGjP29w5KPleNh6hrAWJET
         ZcrXfRVM2F0VNyTd5OoodGXlnOllf/02Xfx8d5Fi/XSkbaNbkkrzUx5GLEJfSCldTs/Y
         7M9cdfn/bJUmMlUZdBTJO/xcX5cKRHAaeMPor9qGci/Ils/cdZlvmqk7vEAKjOIjpWJ8
         dVV3rONLYXcgqDMiE5lStNPu83YGdHkRCe3FqNsN3QR1K0+2XgvBmeqE+q8+9znHka5h
         H5iA==
X-Gm-Message-State: AJIora/o31ATPiYXi1WtMK91DI6591JMFgbFH0JKbzOvA59iBWRUy7dL
        50TwmdRze0kOs4vObsXrrqja
X-Google-Smtp-Source: AGRyM1t5PF0DSFrQbt4bi5LBPcIBQxZL7P89Hk2jkSRxl7RATw5BhQNCdgNUDq/Dg1qVd17q5SsXwQ==
X-Received: by 2002:a05:622a:110b:b0:31d:3958:e6e9 with SMTP id e11-20020a05622a110b00b0031d3958e6e9mr22319256qty.660.1657120150141;
        Wed, 06 Jul 2022 08:09:10 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id u16-20020a05620a431000b006a7284e5741sm30587670qko.54.2022.07.06.08.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 08:09:09 -0700 (PDT)
Date:   Wed, 6 Jul 2022 11:09:08 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Douglas Anderson <dianders@chromium.org>,
        linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
        linux-security-module@vger.kernel.org,
        Milan Broz <gmazyland@gmail.com>
Subject: Re: [PATCH v7 3/3] dm: verity-loadpin: Use
 CONFIG_SECURITY_LOADPIN_VERITY for conditional compilation
Message-ID: <YsWllA0uZadrrXut@redhat.com>
References: <20220627153526.3750341-1-mka@chromium.org>
 <20220627083512.v7.3.I5aca2dcc3b06de4bf53696cd21329dce8272b8aa@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627083512.v7.3.I5aca2dcc3b06de4bf53696cd21329dce8272b8aa@changeid>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27 2022 at 11:35P -0400,
Matthias Kaehlcke <mka@chromium.org> wrote:

> The verity glue for LoadPin is only needed when CONFIG_SECURITY_LOADPIN_VERITY
> is set, use this option for conditional compilation instead of the combo of
> CONFIG_DM_VERITY and CONFIG_SECURITY_LOADPIN.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Acked-by: Kees Cook <keescook@chromium.org>

Acked-by: Mike Snitzer <snitzer@kernel.org>
