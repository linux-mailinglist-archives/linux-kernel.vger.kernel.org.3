Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217A556BD6E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238836AbiGHP2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237057AbiGHP2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:28:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9161E73904;
        Fri,  8 Jul 2022 08:28:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 347E5B824F6;
        Fri,  8 Jul 2022 15:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCE2C341C0;
        Fri,  8 Jul 2022 15:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657294085;
        bh=KAfXERdqbtilgXrs/mlOi+seJobFePGOK/Z/qHdIrPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fa0QzF3gez7GOGb5Jbc4Q5RU38Yl6LieKGxFgCPAKWHXPxMdnzStPP6p/w9bxY83G
         feiBvLdAehuZ8+c7W6CBmtJzwRrcSLnSTbhAUyPGpLRpNPJ/qPMn2Gzsf2EhBbkQQt
         2TmHxpdM+28JFO/k4wcovTDi5Ob1TsDCjD8X35lk=
Date:   Fri, 8 Jul 2022 17:28:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jithu Joseph <jithu.joseph@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, ashok.raj@intel.com,
        tony.luck@intel.com, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH] platform/x86/intel/ifs: Allow non-default names for IFS
 image
Message-ID: <YshNAh6awfPFmxzU@kroah.com>
References: <20220708151938.986530-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708151938.986530-1-jithu.joseph@intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 08:19:38AM -0700, Jithu Joseph wrote:
> Existing implementation limits IFS image to be loaded only from
> a default file-name (ff-mm-ss.scan).
> 
> Change the semantics of the "reload" file. Writing "1" keeps the legacy
> behavior to reload from the default "ff-mm-ss.scan" file, but now interpret
> other strings as a filename to be loaded from the /lib/firmware/intel/ifs
> directory.
> 
> Situations where multiple image files are helpful:
> 1. Test contents are larger than the memory reserved for IFS by BIOS
> 2. Increased test coverage
> 3. Custom test files to debug certain specific issues in field

Ick, but now what namespace are you saying that path is in?  If you need
debugging stuff, then put the api/interface in debugfs and use it there,
don't overload the existing sysfs api to do something different here.

> Fix the below items in adjacent code
> - Return error when ifs_image_sanity_check() fails in ifs_load_firmware()
> - Correct documentation "ifs.0"->"ifs"

That should all be a separate patch, you and Tony know better than this.

{sigh}

greg k-h
