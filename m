Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A55B56934A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbiGFU0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiGFU03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:26:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C8CE175BC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 13:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657139187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Hwo8z020LeTeWlRuuo4HAd1S0dCDtVbRtMDTaTwRBo=;
        b=ejeK9DIOX3xVaqkEeI9e5HLAq/TLWpQZ0AQmh6HGOTclj8fGJLl++UtaDkQaYrPrElPUUl
        mHGia1zfc88GpiC7wUzr4SOGG0nzqd5M1tRNFmG4eob4D+J3ufD735xuoeHz2iaC6XJ5sA
        ngQBl/hJZxNx2A0N0PQlK9QrwCzzZuc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-wukfxnikOimILhkgfZjzDA-1; Wed, 06 Jul 2022 16:26:26 -0400
X-MC-Unique: wukfxnikOimILhkgfZjzDA-1
Received: by mail-ej1-f72.google.com with SMTP id sh39-20020a1709076ea700b0072aa3156a68so2975030ejc.19
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 13:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4Hwo8z020LeTeWlRuuo4HAd1S0dCDtVbRtMDTaTwRBo=;
        b=oSevnN2P6o9Uw0+mlWQoDzJTe61fsfu1N3xFRlgV3aBJVrevtvoFXFhmeLEyNh5tv8
         Zv233cYS2xI65BohspPt2Vpvhfkhc7T+oR3eykIGesOHjmdAjGVePJj18Jy8vilDyWBw
         bE+GvcUOPBSZF8Qtj/bdJ09T2oK5pGI9MJR85rBuHQZGCPmG3p2tHAAcx9IiihxSWG3Q
         cipGi7OjFL/jiXCR4g6c8VbOico+ZPlV/H0t03ZwkHqoDCcRX/YgL9K24oSnuFyoBu5p
         /Fj3P4hcCFefOvF3dkFK7sGx6Szf2koXWDesR8UDOzez6NRUYNuMTR/DOqsGtgij+UFY
         ZRCw==
X-Gm-Message-State: AJIora/xuxqAdGqGjypsPF2857Ajjn+OboB0LImaE1j1Frke0t1z5ZNh
        U/MZjS//BF3/ZQMfodhU/5QBZ0vY7jlkbNxQcRA0AC36YMmzPm5F6m4b6k/b6T2EH8JSJTKE0oi
        L09k4hdPR3P3so09ZSjbRVFGx
X-Received: by 2002:a17:907:6d1e:b0:726:abf9:cb90 with SMTP id sa30-20020a1709076d1e00b00726abf9cb90mr39141418ejc.685.1657139185172;
        Wed, 06 Jul 2022 13:26:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1stSh0sgO2t5SPZoQVNYoYGxZ7B79qOA1aObb55Rkl5ftoOw1kl+bnhUEKWqBDT9am0abeQRQ==
X-Received: by 2002:a17:907:6d1e:b0:726:abf9:cb90 with SMTP id sa30-20020a1709076d1e00b00726abf9cb90mr39141402ejc.685.1657139184895;
        Wed, 06 Jul 2022 13:26:24 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id bm4-20020a0564020b0400b0043a8f40a038sm1770337edb.93.2022.07.06.13.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 13:26:24 -0700 (PDT)
Message-ID: <be219334-456f-c2f1-7102-4a3b01e8cd59@redhat.com>
Date:   Wed, 6 Jul 2022 22:26:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC][PATCH] ACPI: EC: Make evaluate acpi_ec_add() _REG for EC
 operation regions
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <5592689.DvuYhMxLoT@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <5592689.DvuYhMxLoT@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/6/22 14:37, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> acpi_ec_ecdt_probe() is called between acpi_load_tables() and
> acpi_enable_subsystem().  It passes ACPI_ROOT_OBJECT as ec->handle
> to acpi_ec_setup() and so ACPI_ROOT_OBJECT is passed to
> acpi_install_address_space_handler() via ec_install_handlers().
> 
> Next, acpi_ns_validate_handle() converts it to acpi_gbl_root_node
> which is passed to acpi_ev_install_space_handler() and the handler is
> installed for acpi_gbl_root_node.
> 
> Now, acpi_gbl_root_node is passed to acpi_ev_execute_reg_methods() which
> evaluates _REG for any ACPI_ADR_SPACE_EC regions it can find in the
> namespace which should not be necessary, because the OS is expected to
> make the ECDT operation regions available before evaluating any AML, so
> in particular AML is not expected to check the evaluation of _REG before
> it accesses these operation regions (see ACPI 6.4, Section 6.5.4,
> exception 2 [1]).  Doing that is also problematic, because the _REG
> methods for the ACPI_ADR_SPACE_EC regions may depend on various _INI, so
> they should be be evaluated before running acpi_initialize_objects() [2].
> 
> Address this problem by modifying acpi_install_address_space_handler()
> to avoid evaluating _REG for ACPI_ADR_SPACE_EC regions when the handler
> is installed for acpi_gbl_root_node which indicates the ECDT case.
> 
> However, this needs to be accompanied by an EC driver change to
> actually trigger the evaluation of _REG for the ACPI_ADR_SPACE_EC
> regions when it finds the EC object in the namespace.
> 
> Link: https://uefi.org/specs/ACPI/6.4/06_Device_Configuration/Device_Configuration.html#reg-region # [1]
> Link: https://github.com/acpica/acpica/pull/786 # [2]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Note: This change doesn't make any practical difference on any of the systems
> in my office.
> 
> ---
>  drivers/acpi/acpica/evxfregn.c |   12 ++++++++++++
>  drivers/acpi/ec.c              |    7 +++++++
>  2 files changed, 19 insertions(+)
> 
> Index: linux-pm/drivers/acpi/ec.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/ec.c
> +++ linux-pm/drivers/acpi/ec.c
> @@ -1632,6 +1632,13 @@ static int acpi_ec_add(struct acpi_devic
>  			acpi_handle_debug(ec->handle, "duplicated.\n");
>  			acpi_ec_free(ec);
>  			ec = boot_ec;
> +			/*
> +			 * Uninstall the EC address space handler and let
> +			 * acpi_ec_setup() install it again along with
> +			 * evaluating _REG methogs associated with
> +			 * ACPI_ADR_SPACE_EC operation regions.
> +			 */
> +			ec_remove_handlers(ec);

This will call the _REG method to get called with ACPI_REG_DISCONNECT (0)
as second argument which may lead to unexpected consequences so I'm not
in favor of doing things this way.

IMHO it would be much better to instead have flags; or if flags are
disliked a separate function to only call _REG later on.

>  		}
>  	}
>  
> Index: linux-pm/drivers/acpi/acpica/evxfregn.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpica/evxfregn.c
> +++ linux-pm/drivers/acpi/acpica/evxfregn.c
> @@ -78,6 +78,18 @@ acpi_install_address_space_handler(acpi_
>  		goto unlock_and_exit;
>  	}
>  
> +	/*
> +	 * Avoid evaluating _REG methods if an EC address space handler is
> +	 * installed for acpi_gbl_root_node, because this is done in order to
> +	 * make Embedded Controller operation regions, accessed via the Embedded
> +	 * Controllers described in ECDT, available early (see ACPI 6.4, Section
> +	 * 6.5.4, exception 2).
> +	 */
> +
> +	if (node == acpi_gbl_root_node || space_id == ACPI_ADR_SPACE_EC) {
> +		goto unlock_and_exit;
> +	}
> +

Hmm, I like this in that it is KISS. But OTOH this does mean that
acpi_install_address_space_handler() now behaves differently depending on its
parameters in a possibly surprising way. So IMHO this feels a bit too clever
for our own good, since it may surprise the callers of this function.

My biggest problem is, that as indicated above I believe that instead
of uninstalling + re-installing the handler we really need to have a way
to just call _REG later; and that in turn requires the caller to know if
_REG has run or not.

I've posted a new RFC patch series which adds flags to
acpi_install_address_space_handler() to not run / only run _REG :

https://lore.kernel.org/linux-acpi/20220706201410.88244-1-hdegoede@redhat.com/

this then gets used in the drivers/acpi/ec.c patch to defer calling _REG when
registering the handler based on the ECDT until the DSDT EC entry is parsed.
I personally like how this turns out and IMHO this is cleaner (less hackish)
then the proposed solution with calling ec_remove_handlers(ec) :

https://lore.kernel.org/linux-acpi/20220706201410.88244-3-hdegoede@redhat.com/

Regards,

Hans






>  	/* Run all _REG methods for this address space */
>  
>  	acpi_ev_execute_reg_methods(node, space_id, ACPI_REG_CONNECT);
> 
> 
> 

