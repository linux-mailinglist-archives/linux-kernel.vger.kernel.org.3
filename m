Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92174570DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 01:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiGKXIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 19:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiGKXIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 19:08:21 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C5E88776;
        Mon, 11 Jul 2022 16:08:20 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id l24so6329083ion.13;
        Mon, 11 Jul 2022 16:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zxeI3PHxARnofEwCwPc7UJKNkPBUujUtjX7T02fdRTE=;
        b=ZdwBLGVdXsaZd81BTw4CVTl4EH59Oy8IpLGVYMUnQSeLCeKZx41N5Grnjn7V+6Jo4F
         HPCOFnpVG9RthNJ71JrVgvRFqqFU9NEIuyocJkX8YQgF9mYeoYfRmjdLp1xyTYsenVvj
         659+WOcsgzi/hM3TtxwchK0mQCVBl9/Z9u/2M9q5gvqtpkdDa0kI5EbnHKc1IpY+jMXj
         NbCYzD5n44CCnYJY2yXEt8rpjpmmHFliANCFYi1uMhdsYvvCeAEpPRn4lDKHgb7KkJHa
         5qyxnnQCSwWT+s38pi0FrV30suIt93zdzK8saCvAL4tI88mpwjGOaggGSZDJDpXWznN9
         su+A==
X-Gm-Message-State: AJIora/oSAWEndvb3QvIo90N98T1lVczcAiFK76PFx2JncoFR35ZFJYA
        ebE1WuALhTbhNUzFLaPxDw==
X-Google-Smtp-Source: AGRyM1s3bAM9D4kuHyYfELQim8LOvE/a+WptFtkWi4E/UQYgphGHqVpb9+0rM3NLTNQgt7wsHF05NQ==
X-Received: by 2002:a6b:c6:0:b0:678:e850:daa with SMTP id 189-20020a6b00c6000000b00678e8500daamr10642819ioa.104.1657580899905;
        Mon, 11 Jul 2022 16:08:19 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z12-20020a92d6cc000000b002dc1b9121ccsm3160251ilp.17.2022.07.11.16.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 16:08:19 -0700 (PDT)
Received: (nullmailer pid 441104 invoked by uid 1000);
        Mon, 11 Jul 2022 23:08:18 -0000
Date:   Mon, 11 Jul 2022 17:08:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frank.rowand@sony.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] of: unittest: Switch to use fwnode instead of
 of_node
Message-ID: <20220711230818.GA441024-robh@kernel.org>
References: <20220708214539.7254-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708214539.7254-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Jul 2022 00:45:38 +0300, Andy Shevchenko wrote:
> The OF node in the GPIO library is deprecated and soon will be removed.
> GPIO library now accepts fwnode as a firmware node, so switch the module
> to use it instead.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
> v2: added tag (Bart), clarify the purpose in the commit message (Rob)
>  drivers/of/unittest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!
