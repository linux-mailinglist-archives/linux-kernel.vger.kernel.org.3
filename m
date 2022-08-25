Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B6E5A0A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbiHYH0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237489AbiHYHZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:25:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071B3A2AA7;
        Thu, 25 Aug 2022 00:25:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4A1B7CE25F6;
        Thu, 25 Aug 2022 07:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15B2C433D6;
        Thu, 25 Aug 2022 07:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661412329;
        bh=raOy4Yn3E+DdufgeOAQn1fCgFIUBZVSXQY1vthuQZ0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/HCkq6IyZIIxGa/lWMmoN5kNtGAEaEDt4EuzrewZNSErAmM71CPx99PTmGi5GtpG
         8d5rfQyr2lG7p7FS1Wb5KobjDyvnXfiTyFIyU0RPxVa6ssdxejogj+oavLUxm324pX
         SKraYhX+/+rP+/U/SLgV7n65odzggcNABItwFp38KIj13dPG2Dtrk6nFjnxjDaFFDt
         94r04MwC1FIOhTuMe09IT6iomsN2NgIE9qZyBlYQWPdfdNyscNEz0W1/Nm72gI9sbo
         2Tg2ZNzV8npDOqRcgOiKf3xoTIoFuxPVRoeb+boNMnAPokFzR7nBBSzNqxvQg9im2m
         o0kbmJ9HLIe4g==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     sbinding@opensource.cirrus.com
Cc:     andriy.shevchenko@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        rafael@kernel.org, sakari.ailus@linux.intel.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v1] ACPI: Property: Fix type detection of unified integer reading functions
Date:   Thu, 25 Aug 2022 09:25:05 +0200
Message-Id: <20220825072505.316002-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220812130645.14710-1-sbinding@opensource.cirrus.com>
References: <20220812130645.14710-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664; i=ardb@kernel.org; h=from:subject; bh=raOy4Yn3E+DdufgeOAQn1fCgFIUBZVSXQY1vthuQZ0o=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjByPQGLjCijOjO/FyM/H9lntnWXG5F4x/nvT3Ufkv xQVQlrGJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYwcj0AAKCRDDTyI5ktmPJDLoDA C4oMlru2DIvBCdCcUQY494b9Qviel2j1CKAc4vYAxSz97KvJORpQMpVEW/xzDiWSxhA5DGKBUDjFJG bpJbTuEeYUqBpUr+dM4K5FSR3RaLy8XUOWdL7Ip197qoSpwDoK+TLqT2Rcjg0aSwlV5cPXizHcl14E tFzbzmiaaTX/Pj9rcD3POvq/aVsXSLsPyi8w10rBc33yRA23mfGl/P0s7JGJexQ+5gGeJncZohFcxV mOnivBIwph0X0xqHRR7EEud9cq9rv+RQ0hS5BwnZJZvHex0pBvzAznjdhAbCJpao66origns7wuc9N IfBH8GjYnpNnffhulrj0fl1TIiUjNiOzvDoITAe7x1AaSVaYPJxZy8s42Z8wCd7qXwnsvoMZ0KVz0q RFkRlLw2Ts3IQdZWqKpmJ/N1F5hlvh88snNND//02HNi+aHV5TxGN2rGraSBei4azUllW9kVUDhZDb IlZ5VfJ4x0NfG2GIOBwF4rUDTC1BROZ6G5cxiDdk0AnaQ=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The current code expects the type of the value to be an integer type,
> instead the value passed to the macro is a pointer.
> Ensure the size comparison uses the correct pointer type to choose the
> max value, instead of using the integer type.
> 
> Fixes: 923044133367 ("ACPI: property: Unify integer value reading functions")
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

Can we get this queued up and sent out please? This is breaking some ACPI arm64
systems, which use device properties for their MAC addresses.

Some grumbling about the original patch below.

> ---
>  drivers/acpi/property.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 7b3ad8ed2f4e..b1d4a8db89df 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1043,10 +1043,10 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
>  				break;					\
>  			}						\
>  			if (__items[i].integer.value > _Generic(__val,	\
> -								u8: U8_MAX, \
> -								u16: U16_MAX, \
> -								u32: U32_MAX, \
> -								u64: U64_MAX, \
> +								u8 *: U8_MAX, \
> +								u16 *: U16_MAX, \
> +								u32 *: U32_MAX, \
> +								u64 *: U64_MAX, \
>  								default: 0U)) { \

Why is there a default here? Having one is what hides the fact that the patch was completely broken.

>  				ret = -EOVERFLOW;			\
>  				break;					\
> 

Also, I must ask: given how broken the original patch is, I suppose no testing whatsoever was done? 

Thanks,
Ard.

