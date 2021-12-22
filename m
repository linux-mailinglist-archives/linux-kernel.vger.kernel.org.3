Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41D847D5A4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbhLVRRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:17:15 -0500
Received: from mail-qv1-f42.google.com ([209.85.219.42]:43970 "EHLO
        mail-qv1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhLVRRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:17:12 -0500
Received: by mail-qv1-f42.google.com with SMTP id fq10so2887976qvb.10;
        Wed, 22 Dec 2021 09:17:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A+warVrbZ1rSpFdDflw1rVq6fcBj5XMeMggY16ONxI8=;
        b=yKy80yhcxLnhAI/gIJC9iS4eNVT9x3tDlVK+zli92ukD7j8lWMcoJPeVqCltkeHYRw
         ZdeqlDfPzj1CChioYoPr7g8HyDTZPe80hcGVQp4Gp4GzgeaqK6jWcRMEQ2915A9OHP+A
         8el/9pkYT6xHABHTKBTrmTrH2KEWRqy3Ccm0bf7x3etA4ntY2kAn0LW7O9aAiPyqqiFR
         BZGy659JTGHx+vbQowubsluSKu2HwFF5jtWSoUzFNVcbjaj2XtpYb5KQV9xvIFzYZ9n8
         FJoJ4znrrdyFj1csQwSLm6LeiYm3p64WH1QI6JwtEUetGCpeJcuoUGsne8uIsGG/k+2j
         j1NQ==
X-Gm-Message-State: AOAM533cjHeSd9Y+BJMMF+k9d8dKrqXOfOZHmQwa//kR5us3DzYp85wN
        Zz22MGGaQ9sQkNmWFoSDgF4pDFpU09ms
X-Google-Smtp-Source: ABdhPJz28QcGjYbqaNcyw8MLZuNSVIYkX2yRXs7A/+8nLgT8bq6nlL4TyIcGUnOBc2aDc/vIEGr+Jw==
X-Received: by 2002:a05:6214:238e:: with SMTP id fw14mr3315762qvb.86.1640193432154;
        Wed, 22 Dec 2021 09:17:12 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id y20sm2323830qkj.24.2021.12.22.09.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 09:17:11 -0800 (PST)
Received: (nullmailer pid 2345794 invoked by uid 1000);
        Wed, 22 Dec 2021 17:17:09 -0000
Date:   Wed, 22 Dec 2021 13:17:09 -0400
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: bindings: Warn about yamllint and
 dt-schema before submitting patches
Message-ID: <YcNdlaxuGzhDlNKf@robh.at.kernel.org>
References: <20211216164727.2888916-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216164727.2888916-1-alexandre.ghiti@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 05:47:27PM +0100, Alexandre Ghiti wrote:
> Make sure people know that yamllint must be installed and dt-schema up
> to date before they submit device tree bindings patches.
> 
> Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> ---
>  Documentation/devicetree/bindings/submitting-patches.rst | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/submitting-patches.rst b/Documentation/devicetree/bindings/submitting-patches.rst
> index 36a17b250ccc..3553e90bef5a 100644
> --- a/Documentation/devicetree/bindings/submitting-patches.rst
> +++ b/Documentation/devicetree/bindings/submitting-patches.rst
> @@ -25,6 +25,10 @@ I. For patch submitters
>  
>         make dt_binding_check
>  

This will already tell you if dt-schema is out of date.

yamllint is optional for the build system, but we could make it 
required or warn when not present. I think people do get surprised by 
yamllint warnings reported.

> +     Make sure yamllint is installed and dt-schema is up to date::
> +
> +       pip3 install dtschema --upgrade
> +
>       See Documentation/devicetree/bindings/writing-schema.rst for more details

This already has details on running pip3, so now we have it in 2 places. 
And they don't match because writing-schema.rst says how to install from 
git rather than pypi. Not sure what happens if you install from git and 
then run the above...

>       about schema and tools setup.
>  
> -- 
> 2.32.0
> 
> 
