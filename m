Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F097D501FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 03:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348326AbiDOBKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 21:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348318AbiDOBKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 21:10:34 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE7652E5E;
        Thu, 14 Apr 2022 18:08:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 21so8409682edv.1;
        Thu, 14 Apr 2022 18:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cpinv0gHO+HxVm83FVzuNg/GVVXCEmgbgcCu4WDaj7M=;
        b=Ffg7XcD9snn2//qJljQ5v+P7ngZV1vDMeFevxj0RrIeSf2mwsp5r7LSIT9RTakX22R
         /+RRihuzrYpU0fBPxlhWhhJh0nQfzFAUFe/W4uZCWP9kUl71jGvT4HVjATOw+D2F5YjZ
         08sPZeDiY5ZyRiCNnK7qIt6SdwZyhD3/mHyTUstaoGgQA2AdR5YFq3X1rae38wEh0GRB
         CAyZaEdrfdKuy1XCeOh0gHzaorLylrjd+HuYDEg0FL4GMgZjnJ41yJEKhJErkzkQhPcJ
         2UjZZ1uQeBJEvb1c8X4sdsJldqmWk08ORVPkEECoUP+HoOwalsUvNEw+3xaZ+XSvAkqr
         zj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cpinv0gHO+HxVm83FVzuNg/GVVXCEmgbgcCu4WDaj7M=;
        b=R/fqa+oZz+yUQyNshkX9WT1vy2L6fXSXuvSyOvSH2KUELLWuuDOINI8a6+94BgbDMc
         qKSJ/jht3Glk9MKU7DjekZIAT/9RNEl23jK4p2Ohty3SBnC85h+P95Htqpz0p+SNsuod
         YsoZ7Cd14vAMIno1Kxoyn//ifbzS1865b68kqzH7XAKZuTd9xju4tBCFBnaFxk66kLK4
         e39LSZS8F6n9yhMjvW6+VK+or3DN6DQEjEU5zuCICGDIjrbvWtARZWA0gv3R+uxUNLJQ
         MsDTb+Af7EUn4LjXGAxg5UsyGWfEUyrnUC75gZBCUr0AcjifvDoIf3q3r+gsJ02QgbPg
         r9LA==
X-Gm-Message-State: AOAM531LggJvYKBqAv7qGDtuj7qVE8pcS3CLVrP6smdZAh0Av1Q5E0sa
        bAMtorlswxBmKhtwuoiRXAE=
X-Google-Smtp-Source: ABdhPJyDjxkouJ0VBiQARUFq4JVw6eshlqNYqQSSEvzricjMxsG5DAG8olEisMcVleCmDTv66mkbeQ==
X-Received: by 2002:a50:d087:0:b0:41d:7ea6:462a with SMTP id v7-20020a50d087000000b0041d7ea6462amr5863585edd.355.1649984886575;
        Thu, 14 Apr 2022 18:08:06 -0700 (PDT)
Received: from leap.localnet (host-79-43-11-75.retail.telecomitalia.it. [79.43.11.75])
        by smtp.gmail.com with ESMTPSA id g24-20020a1709063b1800b006e8cf786ee8sm1134001ejf.21.2022.04.14.18.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 18:08:05 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Martiros Shakhzadyan <vrzh@vrzh.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: media: atomisp: Use kmap_local_page() in hmm_store()
Date:   Fri, 15 Apr 2022 03:08:03 +0200
Message-ID: <4415369.cEBGB3zze1@leap>
In-Reply-To: <Yli+R7iLZKqO8kVP@iweiny-desk3>
References: <20220413225531.9425-1-fmdefrancesco@gmail.com> <Yli+R7iLZKqO8kVP@iweiny-desk3>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On venerd? 15 aprile 2022 02:37:27 CEST Ira Weiny wrote:

> Regardless now that kmap_local_page() exists, this is correct.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

I'm pretty sure this particular patch would have had a hard time getting 
accepted without any authoritative "Reviewed-by" tag from you or other 
people more experienced than me.

Thank you very much!

Fabio M. De Francesco


