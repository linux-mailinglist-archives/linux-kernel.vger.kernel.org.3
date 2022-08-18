Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B47598D87
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345712AbiHRUNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345607AbiHRUNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:13:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74D4B8F29;
        Thu, 18 Aug 2022 13:11:40 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id a22so2531332pfg.3;
        Thu, 18 Aug 2022 13:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=keeiDaK9Q+Jdo90jj1BSU2Ge6qhncob/UO4SDy8WdlY=;
        b=fHlgswuc4yHJpES0GrJgQ2nYRNd6KIPJGokMB5R43+hsmIl/yScP3PLabbkWDJoA6M
         itbHDxtVkf2EFRZWuSYVPgVsdW3cpj/X6sF815f3tE7p8IIWi0UN5E6qh3FaTUP1s6MQ
         /mvqXnieTaO1WCT78vNk97MTZC7y4+vDP/YKstrauwle9g+o71ecxT5e6AHpZ54Rp/X7
         AbptsNPOlbcBu75KYydWRQ3RsV82HNw34KilZrNCXf5Hd4xjR8R7e2GvB3IGQaKU5Csa
         pnlYSPCDAstOwnUetKn3ZkOdTWwINBtKRQxfEMF6vAZjprVlHCa2am8AvpAY+tjpR1Pj
         uWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=keeiDaK9Q+Jdo90jj1BSU2Ge6qhncob/UO4SDy8WdlY=;
        b=xfZ7zhjNGXpuIpePirDKBm43p7Nhgz99a9mBIbfnWXbUz9PwBYstnVWvWBLB+5aoJL
         VdPNlsE6PS2F89syE9lGavVRWlF1w9V0ffTZQlKJuC6vulhafaIpkV59X2PdoXiSeVQL
         q5MvnbpUaGKbf2pHv/0Hg/nAqEgNZEWv/E9NVvFZEUiP5ruzDU/zQJoK0zTzT+0lMo/s
         Toc0XXqy804ZXC9Y87aNnrTNO0eaUtjKFkVH9sQXg5T+68sCMbusYumMMdB3HvhLez9r
         zvHbn6hcupifEN+fqE9IUV9JiZ7RVPosND1n4nc62lnQMmcPNhilQsPO7SIJTDZLk5oy
         egIg==
X-Gm-Message-State: ACgBeo0e8uDyJqH4rqaK9bKsMFaOZFbsciAIU6BiXCaRqcMjk3ccPuD0
        yN3t6JchmsbKHRLhjPsroRYjpxUnJ5w=
X-Google-Smtp-Source: AA6agR5uEc8aeOY6+WeukG1fydlhDLzISuJ21H4VGppEP0Mx432m2/yOrx2isICQGqmhSJG2z9CKPA==
X-Received: by 2002:a05:6a00:2906:b0:52a:bc7f:f801 with SMTP id cg6-20020a056a00290600b0052abc7ff801mr4513710pfb.49.1660853500357;
        Thu, 18 Aug 2022 13:11:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b191-20020a621bc8000000b0052d2b55be32sm2066951pfb.171.2022.08.18.13.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 13:11:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 18 Aug 2022 13:11:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dwmw@amazon.co.uk,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v2 09/16] hwmon: (mr75203) add VM pre-scalar property for
 Moortec PVT controller
Message-ID: <20220818201138.GA3423710@roeck-us.net>
References: <20220817054321.6519-1-farbere@amazon.com>
 <20220817054321.6519-10-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817054321.6519-10-farbere@amazon.com>
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

On Wed, Aug 17, 2022 at 05:43:14AM +0000, Eliav Farber wrote:
> vm-pre-scalar-ch# is a per channel optional parameter that can be
> used to normalzie the voltage output results.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  .../devicetree/bindings/hwmon/moortec,mr75203.yaml        | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> index 6111b5069b3c..e2a55001eefc 100644
> --- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> @@ -56,6 +56,12 @@ properties:
>        A value of 0 means that the entire VM sensor is nou used.
>      $ref: /schemas/types.yaml#definitions/uint8-array
>  
> +  vm-pre-scalar-ch#:

Is that how such properties are implemented ? Seems to me that
results in a lot of decode complexity.

Why not use an array property like the other properties ?

Guenter

> +    description:
> +      vm-active-channels defines the pre-scalar per channel value
> +      used to normalzie the voltage output results.
> +    $ref: /schemas/types.yaml#definitions/uint32
> +
>  required:
>    - compatible
>    - reg
> @@ -68,6 +74,7 @@ additionalProperties:
>    - intel,vm-map
>    - reset-control-skip
>    - vm-active-channels
> +  - vm-pre-scalar-ch#
>  
>  examples:
>    - |
> @@ -82,5 +89,6 @@ examples:
>          clocks = <&osc0>;
>          resets = <&rcu0 0x40 7>;
>          vm-active-channels = [08 10 02];
> +        vm-pre-scalar-ch5 = <2>;
>          #thermal-sensor-cells = <1>;
>      };
