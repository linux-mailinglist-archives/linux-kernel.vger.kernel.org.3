Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FA652B1C7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 07:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiERFGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 01:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiERFGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 01:06:17 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7421C63BFE;
        Tue, 17 May 2022 22:06:15 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id oe17-20020a17090b395100b001df77d29587so4548729pjb.2;
        Tue, 17 May 2022 22:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XRlsgT/DhPOQs8SJOPJpABXkZ441U4eTkofnVJR9/V0=;
        b=gw/mDhni92fmwnaUg618f+wzz9908yL+rd0nTfay+zsDORoQHW22NvfLKAWGLdocYI
         ommPn3F8OsYjdazmSfOyHjrf3LwEgRY4Y2rnLKwYYcs5CK0HGeUPuEZh9S20VkfMTW1B
         B3T421gBglYuMNX4n9TnJ/30ew4Pbwfn7bncxPSQ7RQDLmS9oIvY8Ti5xT91S9cg7BvO
         K84zAVxzTu6AlF5YLNRYW28XRhBoVmQs5L1SFBh1VNx6qvQEwW3FfxIuDNFSC9p7f3js
         0dIjldDLL4uc8Je7UgD370y0I0TH69ZdarTkKj61y/VVvsc3IDEmwtxZvpGCuCbDHeXy
         2x/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XRlsgT/DhPOQs8SJOPJpABXkZ441U4eTkofnVJR9/V0=;
        b=aV6Orrc5c8MPat/Y7rEuKebOAIY6W3qa5qMSLZA56JdV1s0BiSkQpAtuHD338f8JRA
         peA5POohFRfapUxF9wluYK/inSYORSEUKQCp5czO2E0qrJz7yk1G6odh0Ync/pERZiEd
         AJUSCuprUlHUC2KPlA4/BhBZuPKyrHySjarykIIFO8CI4pIzHd3bcXxftvtXbbdiJaCX
         PBXWj2pivM9bW4/62i9Y4yxGhna2EaJ6bZG6OjAUPXdWGH37LNtIEa4V0t8P6SYtcIaj
         ZR6TQvzVfQtHIcbYf38xjZIe8p8O9ulLtUVOZK6azlcESMbPw+RS+3rSQCMgpJEKfHEp
         InTQ==
X-Gm-Message-State: AOAM531KYc4UXSnQ02hrQQj/jfhBN2YdyqtMFRqXB8Cm8cVW4eFl244Z
        dOXP5JTGTB5akZqPDlV+6n0=
X-Google-Smtp-Source: ABdhPJz/Ts716RSWDtwDnqjE6nbvnA/HhsrFs7hdFknU2JjN18U3m/JtJ62iHxHnqxMXAPX8m5gm2A==
X-Received: by 2002:a17:902:ccc2:b0:15f:4acc:f202 with SMTP id z2-20020a170902ccc200b0015f4accf202mr25153827ple.3.1652850374886;
        Tue, 17 May 2022 22:06:14 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:556b:348:b181:320f])
        by smtp.gmail.com with ESMTPSA id l17-20020a629111000000b005180cf8f8c2sm651052pfe.169.2022.05.17.22.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 22:06:14 -0700 (PDT)
Date:   Tue, 17 May 2022 22:06:11 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Subject: Re: [PATCH v5 0/2] Input: cros-ec-keyb: Better matrixless support
Message-ID: <YoR+w7CSqN0aAE5b@google.com>
References: <20220516183452.942008-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516183452.942008-1-swboyd@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, May 16, 2022 at 11:34:50AM -0700, Stephen Boyd wrote:
> This is a followup to my previous patch[1] that skips keyboard registration
> when the matrix properties aren't present. This adds a compatible string
> for this scenario so we can ease existing DTBs over to the new design.

As discussed offlist I massaged the binding and the driver code a bit
and applied it to an immutable branch off v5.17:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git ib/5.17-cros-ec-keyb

that you can share with DTS maintainer(s) to accelerate DTS conversions.

I also dropped the original patch as it did not make it to Linus' tree
yet.

Thanks.

-- 
Dmitry
