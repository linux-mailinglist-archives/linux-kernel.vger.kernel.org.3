Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04265B0E3B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiIGUhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiIGUhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:37:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BCC9CCED
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 13:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662583065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KCs8gsbRUWvlhyvj5cjhNbRkewVX67viCj8epnpilrM=;
        b=eV7awr/y7EKSpkPNIsYT+ivcBiHv6ZY9WWalCCnqXti2V4cfkt+v9U+5mGSpd67XDOkM9B
        J3OelUvPDdHkK9fLcENPabobUYcd71HLH3YCJu9UbQY4i2yX6Mdum+vxKicMRwG5c8nhtL
        w0ORRvMeHr0ntuUqGdYxjBhNJ1C8HiE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-1-buU4addFOfWRSOcWnrP-Hg-1; Wed, 07 Sep 2022 16:37:44 -0400
X-MC-Unique: buU4addFOfWRSOcWnrP-Hg-1
Received: by mail-qv1-f72.google.com with SMTP id k10-20020ad4450a000000b004aa116eebe8so5604271qvu.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 13:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KCs8gsbRUWvlhyvj5cjhNbRkewVX67viCj8epnpilrM=;
        b=7ftEOQOdtJBKyCXpjtgEoiAWFWhvrMl1FfXGuoIagoUIrw40fJfgmtBpWd3BcLqHZL
         Ojkyv6c+NihsiPSgcdM5gQfGWjH2eM8FzuoNfYpMssJ2oM9O9LlMdnnZaoUB3oT7NdU1
         NLC5BcZnYIkQvy5szEFXxk24rvLOV8bS2ABeZzIPM5JvnfwsVFviLgT3zgMx2DHYy7EW
         UIBdPNed+YkAa0/XRnVibwmpgwjJNLZC6B9cln0PVKhfSqJC7Xb41PWk6TlgLk2yl7hX
         5a7c1iFt1v7tZzwZTjC/npJqaNgwnzVrt7MIEIPmEAt+GbHyaqLeRnDHG2OcXwpyQaJz
         yG/w==
X-Gm-Message-State: ACgBeo1s6KBmo4K+tjHbOr9f+A8kfhMntxeOlfuTPbkt3AhKv2J091Th
        SSnhmA5mllrxaUHUd2HEo0TuDKyNSV89RlcF87/Xw7IMl55xvqtqG+DzYMU4+AZgGbbHQN9HZgv
        L4kZ+xEq8xbeC9pPRTByFeW6f
X-Received: by 2002:ae9:e714:0:b0:6ba:5364:d75a with SMTP id m20-20020ae9e714000000b006ba5364d75amr4164383qka.560.1662583063544;
        Wed, 07 Sep 2022 13:37:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4bGGzLIUcTJAiA6rhq1T0aGGF/LAmdhRPl+BFHLGa05CN0yGN8V3MHdUq6nCjwnjDFX6FQqQ==
X-Received: by 2002:ae9:e714:0:b0:6ba:5364:d75a with SMTP id m20-20020ae9e714000000b006ba5364d75amr4164377qka.560.1662583063338;
        Wed, 07 Sep 2022 13:37:43 -0700 (PDT)
Received: from ?IPv6:2607:fb90:ad9f:c6ba:ed81:2b35:f1ea:dc9a? ([2607:fb90:ad9f:c6ba:ed81:2b35:f1ea:dc9a])
        by smtp.gmail.com with ESMTPSA id 192-20020a3708c9000000b006b60d5a7205sm14492642qki.51.2022.09.07.13.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:37:42 -0700 (PDT)
Message-ID: <cf24580464a758ff58058d4f4826fd39d825befc.camel@redhat.com>
Subject: Re: [PATCH 5.15 011/107] drm/i915/backlight: extract backlight code
 to a separate file
From:   Lyude Paul <lyude@redhat.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jani Nikula <jani.nikula@intel.com>
Date:   Wed, 07 Sep 2022 16:37:41 -0400
In-Reply-To: <YxiDU7mVujuKVqbw@sashalap>
References: <20220906132821.713989422@linuxfoundation.org>
         <20220906132822.225236433@linuxfoundation.org>
         <2bb97268e055b1dd3b3c01c4cbeb54446930e002.camel@redhat.com>
         <YxiDU7mVujuKVqbw@sashalap>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahhhh, sgtm then

On Wed, 2022-09-07 at 07:41 -0400, Sasha Levin wrote:
> On Tue, Sep 06, 2022 at 06:13:17PM -0400, Lyude Paul wrote:
> > Were there parts of this series that weren't Cc'd to me via email? Trying to
> > understand why this patch would be pulled in since it might be required for
> > other fixes, but on it's own there should be no functional changes so it's not
> > really a candidate for stable.
> 
> It's useful for the patch that immediately follows it: 868e8e5156a1
> ("drm/i915/display: avoid warnings when registering dual panel
> backlight").
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

