Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A954AAF14
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 12:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbiBFLxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 06:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbiBFLvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 06:51:10 -0500
X-Greylist: delayed 116 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 03:51:08 PST
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F72C06173B;
        Sun,  6 Feb 2022 03:51:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C4EB60B3B;
        Sun,  6 Feb 2022 11:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A4BC340E9;
        Sun,  6 Feb 2022 11:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644148267;
        bh=LgbUOAbjGglJ4FW76fzaOyzGTdrip6nwKqyf2FbyCtg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rClSM6SmtDb6zi3aDr6KM3B/BZ2zmCL3pdOecSVGja0/OIuL1tK0Sw/Thc4XZKzuU
         cRn9GMAmQqv8zy1BiWeFzJolqZ9dI6zfSma7KMee4O3Y8ceVjg5hTzS5OmfPjQ95xr
         kuAWu/P+bEU/Y/EOSl+72OtKp4dKaLCgab6Fm6ArXFCNtpwCuvA9GKRKs3ev+4dTFf
         B3O74q7l0J0vBEQvnxE7LKCB5SCnlzIF5ZrW5oO6oa0bcWKBOX0UUhPvJOep2WAsHL
         zYfgHB6unpUmCoSqAU97DcBCcaEJNI+MMXb8UMei9UJoJNGECEM3FSA+jZmfDjK5h6
         sgJ2pYI+LguAA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E7CD4404A6; Sun,  6 Feb 2022 08:51:05 -0300 (-03)
Date:   Sun, 6 Feb 2022 08:51:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     German Gomez <german.gomez@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf tools: apply correct label to user/kernel symbols
 in branch mode
Message-ID: <Yf+2KfqJUdcYlSD3@kernel.org>
References: <20220126105927.3411216-1-german.gomez@arm.com>
 <7474e11b-6bd5-515d-0ebf-883d0656a359@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7474e11b-6bd5-515d-0ebf-883d0656a359@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 26, 2022 at 11:27:16AM +0000, James Clark escreveu:
> On 26/01/2022 10:59, German Gomez wrote:
> > @@ -928,7 +928,7 @@ static int hist_entry__sym_to_snprintf(struct hist_entry *he, char *bf,
> >  		struct addr_map_symbol *to = &he->branch_info->to;
> >  
> >  		return _hist_entry__sym_snprintf(&to->ms, to->al_addr,
> > -						 he->level, bf, size, width);
> > +						 to->al_level, bf, size, width);
> >  	}
> >  
> >  	return repsep_snprintf(bf, size, "%-*.*s", width, width, "N/A");
> > 
> 
> Looks good to me, I didn't see any other usages where it could be broken.
> 
> Reviewed-by: James Clark <james.clark@arm.com>


Thanks, applied.

- Arnaldo

