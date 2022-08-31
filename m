Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246DC5A7DBA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiHaMoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiHaMoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:44:11 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB9AD4187;
        Wed, 31 Aug 2022 05:44:10 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c9so10654913qkk.6;
        Wed, 31 Aug 2022 05:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=m7k95wXV4EOCNB06vU0l2Ks5rIPnqD9Owq/g4RCHMIA=;
        b=PyaMDNZ88jhRvVtr3sj/jHaigT1hOfZefsAM7tlR7FXTfh0M4D21DDTNwYnT2PylB2
         3VF1SPSPVPCFyG2Wb7pXgQCAmcSNER6wE9WpkKEyF/D9Kx2pp0Ka7kovHKz5v8f0nFwi
         HSdDQEb4lrPTvjl/08LTvZWP6PkQXYfhNtWYCdwVGqyeMakq2FP6NW0yX3fXOjewffJD
         O1xRWrfevTviW38uu+tVz5kwZrirHYS6RNG1KUZuK2kj8xpD4UJqK66g6ehiq9t/osIS
         3NtHYIy4WQhVt7i30CzEYJSTZXZ0K8nJg8ZUdV7wbBU/3j+UMhyq5OUJYEfy5AxgjJsy
         Er8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=m7k95wXV4EOCNB06vU0l2Ks5rIPnqD9Owq/g4RCHMIA=;
        b=Sw6oySGhaX7wsKhIoOtDOhQkYevdN8gRHRgOVLdqSz90owSJCafl26HljqWoRYXHww
         WiWv7QItI5H7I7NVtckbNL3gmhqBPhD9KBhYje3gdjSWhaeiRj/cU1NtHSh+NwfpuX7I
         zbDgY+j4bspcI99F24G9n/EaWI1Vqth2LQY8SAY4o+yoWo14kI/3EDILmsH4P4ftQWBZ
         X6XREPlbV1lej1VniAMF+hjXd53PKiimiNP1By7BCHgTdLVrlHnVjb0XMU036w5Ob0bV
         alX7I5qIksEO72mVnE/LzqUevuXVs6Wrw7qJ4Fb5S8BFVuboeCGirDuIv2Yr9bT2VMBw
         nWmw==
X-Gm-Message-State: ACgBeo3PGNfHVonZuiefk12DpMrQgLZgvpColmal+zi/5kUhN1yB771p
        4KjgehY/wrgwxsTL/m8z5tc6oQEw+SepfdUyLVo=
X-Google-Smtp-Source: AA6agR5Z9sXnWhOTWzx6SVSqLdH4vnii04aZrKYbs3RFmMOq9YrzEl/hu+rNfrH0v8JPBZEUi8hxadXq+CRN/npRM/c=
X-Received: by 2002:a05:620a:288a:b0:6b8:fcfe:db02 with SMTP id
 j10-20020a05620a288a00b006b8fcfedb02mr15885972qkp.504.1661949849643; Wed, 31
 Aug 2022 05:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220831100506.3368103-1-vincent.whitchurch@axis.com> <20220831100506.3368103-4-vincent.whitchurch@axis.com>
In-Reply-To: <20220831100506.3368103-4-vincent.whitchurch@axis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 31 Aug 2022 15:43:33 +0300
Message-ID: <CAHp75VcfjQ-sMinnpSHQ+_YYMNQ2FnzZdXGsF8dZR7dCxZ8Nhw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] iio: adc: mcp320x: use conv_time instead of
 device_index switch
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, kernel <kernel@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 1:05 PM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> In mcp320x_adc_conversion(), the presence of the chip_info's conv_time
> is used as a condition for using the conversion message.  Use that same
> condition when initializing the conversion message and the other
> handling for variants which need it, instead of the different condition
> (checking of the device_index) which is used currently.

...

> +       if (chip_info->conv_time) {

It would be nice to have conv_time_us renamed before this change.

-- 
With Best Regards,
Andy Shevchenko
