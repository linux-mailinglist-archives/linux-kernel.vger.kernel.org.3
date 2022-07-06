Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3AB5695E5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 01:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbiGFXdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 19:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbiGFXdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:33:45 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A73A2C659;
        Wed,  6 Jul 2022 16:33:44 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q82so8229139pgq.6;
        Wed, 06 Jul 2022 16:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q8RDTkB3VF0pgClV/p2M6N17iiEnC2cE1WV3SlVJSA0=;
        b=FIlpUuQ9LaMQxhJBFRnqT+jVe4QY6P+S5rJuiaR9tGtvCKuZyGJNZEDsVt6pIt9Jtw
         C+0nI6BMDWq3J5p3/htA/T1K1aAbE2HQm6T3ajyjcEm/vNF08HuDxKHWbRjUcyxqxUKr
         6JgOzszqV0TWTTlcHLtma+edwyfnz+FFttLJnPvgEgg19UQa29wLvKOHwN4IrdM0Fq6E
         BAcWK1kDWsQhM8ATrdyyJTYyACmYN7FLjPDLTvYbItiHbriEBOAqe1elWLF2KxlaQQ9T
         FaGdAINE0SW/n+UcXxUDL/oPPhoHszJnRBJL04X/JOVzhsDEcX5R+z1vENNHm3S3mB8t
         Fx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q8RDTkB3VF0pgClV/p2M6N17iiEnC2cE1WV3SlVJSA0=;
        b=HDORgh+TmdDIGt9GKLR5eRnmYFli0OVme1L/CVYjuuZZqZucCju/mdXy51Hf40+Ogb
         MNSJXuSUlCTGiVQxwv6fopmJ1obcwG5jUwhNNLCtk3WaxyAB1UZye8bXuVAZlp9EnG2R
         f+KPeVGJivE8ISLe6t4STAzOhy+slGdxWksvNrS4eEvpXVcKwePepxp2jps72HIvj2oL
         +yPcqLhaB+a65Krst4hEYcKDot+JynNlXsEuP+9i4vpkC5lXqsQVfiGMQy7jzRTxSLrC
         cIVs3CyZVkx5PvUJqOr2U4jsjZew6+o86yMwcCpg0hFTmmaTp43tZzIbkBrRU9C39hT2
         0jKA==
X-Gm-Message-State: AJIora+XkwO2mclQM+1B5HbYGiEj+4FJz1+pk3HRhJ6HIVHccsB/5XJ5
        zTGTkfq9InikcWjyhe4HAxg=
X-Google-Smtp-Source: AGRyM1uj5JNZdwlNSFPppS5J6cDP80PVhRj9doksttKjBMI0kkdJ4K3vKUnIbXyAaBuaWJdqQkMeFw==
X-Received: by 2002:a17:90b:4b8e:b0:1ed:3a07:caad with SMTP id lr14-20020a17090b4b8e00b001ed3a07caadmr1424455pjb.194.1657150423930;
        Wed, 06 Jul 2022 16:33:43 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:9d70:ed48:26b7:35fc])
        by smtp.gmail.com with ESMTPSA id q10-20020a635c0a000000b0040c40b022fbsm23980491pgb.94.2022.07.06.16.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 16:33:42 -0700 (PDT)
Date:   Wed, 6 Jul 2022 16:33:40 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v1 1/1] Input: goodix - switch use of
 acpi_gpio_get_*_resource() APIs
Message-ID: <YsYb1AqZk0nK/Hd9@google.com>
References: <20220705180252.963-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705180252.963-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 09:02:51PM +0300, Andy Shevchenko wrote:
> No need to open code functionality that is provided by the
> acpi_gpio_get_irq_resource() and acpi_gpio_get_io_resource().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied, thank you.

-- 
Dmitry
