Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FFE55700E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 03:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358574AbiFWBpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 21:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiFWBpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 21:45:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEE24349D;
        Wed, 22 Jun 2022 18:45:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DE464CE2228;
        Thu, 23 Jun 2022 01:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DEFC3411B;
        Thu, 23 Jun 2022 01:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655948736;
        bh=+dzhrrPjFPK9MWWwlBMRMR5OjTceYx9uVWofGx/2gqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ClJrvWe2560UsI+RE2mw5IuPiOA7a52sWTyBIy4yIqIoo2wo5DgddUJzi2Wn9wjqq
         G1FA/2HJX4S1xiUN6AYLHy/jwNCX+F2svMDpA0/vg/WmWcpcyd8EPOSFbWs4+v5XuT
         8P8qYfJfWhwYLR2o03rtNQJII+FQPuoLDXr/I9rV+xS++ca3Pla1Nkv4rBO88JIllH
         in5wvWCnHTchLt2quFe8nuyyRyt0oGZb+R8QNpEWZhbZ0MENmseCokAQitXfzMA3A8
         fFhtwCJcrAAxA77rUmjOgyXYbzVixjAe7YCQb6pW8YNVlWx3rO5t0RsymvYnrhTJY2
         jB4jOz7r4bDBA==
Date:   Thu, 23 Jun 2022 03:45:33 +0200
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 3/4][next] scsi: megaraid_sas: Replace one-element
 array with flexible-array member in MR_DRV_RAID_MAP
Message-ID: <20220623014533.GA7132@embeddedor>
References: <cover.1628136510.git.gustavoars@kernel.org>
 <b43d4083d9788bb746dc0b2205d6a67ebb609b0d.1628136510.git.gustavoars@kernel.org>
 <202206221457.1A12D768EF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202206221457.1A12D768EF@keescook>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 03:26:38PM -0700, Kees Cook wrote:
> On Wed, Aug 04, 2021 at 11:20:04PM -0500, Gustavo A. R. Silva wrote:
> > Replace one-element array with a flexible-array member in struct
> > MR_DRV_RAID_MAP and use the flex_array_size() helper.
> > 
> > This helps with the ongoing efforts to globally enable -Warray-bounds
> > and get us closer to being able to tighten the FORTIFY_SOURCE routines
> > on memcpy().
> > 
> > Link: https://en.wikipedia.org/wiki/Flexible_array_member
> > Link: https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays
> > Link: https://github.com/KSPP/linux/issues/79
> > Link: https://github.com/KSPP/linux/issues/109
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> I'd really like to see this fixed. :) I'm running into this 1-element
> array problem now with UBSAN_BOUNDS:

Wow; another forgoten patch from the times we didn't have Patchwork. :) 

> 
> [   10.011173] UBSAN: array-index-out-of-bounds in /build/linux-WLUive/linux-5.15.0/drivers/scsi/megaraid/megaraid_sas_fp.c:103:32
> [   10.087824] index 1 is out of range for type 'MR_LD_SPAN_MAP [1]'
> 
> and I'm not the only one:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=215943

It's actually great that other people are running into these issues now.
That could only means that we should fixed ASAP. :)

We also have this other series that hasn't been applied yet:

https://lore.kernel.org/linux-hardening/cover.1645513670.git.gustavoars@kernel.org/

> 
> > ---
> > Changes in v2:
> >  - None.
> > 
> >  drivers/scsi/megaraid/megaraid_sas_fp.c     | 6 +++---
> >  drivers/scsi/megaraid/megaraid_sas_fusion.h | 2 +-
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/scsi/megaraid/megaraid_sas_fp.c b/drivers/scsi/megaraid/megaraid_sas_fp.c
> > index da1cad1ee123..9cb36ef96c2c 100644
> > --- a/drivers/scsi/megaraid/megaraid_sas_fp.c
> > +++ b/drivers/scsi/megaraid/megaraid_sas_fp.c
> > @@ -229,8 +229,8 @@ static int MR_PopulateDrvRaidMap(struct megasas_instance *instance, u64 map_id)
> >  					le32_to_cpu(desc_table->raid_map_desc_offset));
> >  				memcpy(pDrvRaidMap->ldSpanMap,
> >  				       fw_map_dyn->ld_span_map,
> > -				       sizeof(struct MR_LD_SPAN_MAP) *
> > -				       le32_to_cpu(desc_table->raid_map_desc_elements));
> > +				       flex_array_size(pDrvRaidMap, ldSpanMap,
> > +				       le32_to_cpu(desc_table->raid_map_desc_elements)));
> >  			break;
> >  			default:
> >  				dev_dbg(&instance->pdev->dev, "wrong number of desctableElements %d\n",
> > @@ -254,7 +254,7 @@ static int MR_PopulateDrvRaidMap(struct megasas_instance *instance, u64 map_id)
> >  			pDrvRaidMap->ldTgtIdToLd[i] =
> >  				(u16)fw_map_ext->ldTgtIdToLd[i];
> >  		memcpy(pDrvRaidMap->ldSpanMap, fw_map_ext->ldSpanMap,
> > -		       sizeof(struct MR_LD_SPAN_MAP) * ld_count);
> > +		       flex_array_size(pDrvRaidMap, ldSpanMap, ld_count));
> >  		memcpy(pDrvRaidMap->arMapInfo, fw_map_ext->arMapInfo,
> >  		       sizeof(struct MR_ARRAY_INFO) * MAX_API_ARRAYS_EXT);
> >  		memcpy(pDrvRaidMap->devHndlInfo, fw_map_ext->devHndlInfo,
> > diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.h b/drivers/scsi/megaraid/megaraid_sas_fusion.h
> > index 9adb8b30f422..5fe2f7a6eebe 100644
> > --- a/drivers/scsi/megaraid/megaraid_sas_fusion.h
> > +++ b/drivers/scsi/megaraid/megaraid_sas_fusion.h
> > @@ -1182,7 +1182,7 @@ struct MR_DRV_RAID_MAP {
> >  		devHndlInfo[MAX_RAIDMAP_PHYSICAL_DEVICES_DYN];
> >  	u16 ldTgtIdToLd[MAX_LOGICAL_DRIVES_DYN];
> >  	struct MR_ARRAY_INFO arMapInfo[MAX_API_ARRAYS_DYN];
> > -	struct MR_LD_SPAN_MAP      ldSpanMap[1];
> > +	struct MR_LD_SPAN_MAP      ldSpanMap[];
> >  
> >  };
> >  
> 
> I think this patch is incomplete, and the wrapping struct needs to be
> adjusted too:
> 
> @@ -1193,7 +1193,7 @@ struct MR_DRV_RAID_MAP {
>  struct MR_DRV_RAID_MAP_ALL {
>  
>         struct MR_DRV_RAID_MAP raidMap;
> -       struct MR_LD_SPAN_MAP ldSpanMap[MAX_LOGICAL_DRIVES_DYN - 1];
> +       struct MR_LD_SPAN_MAP ldSpanMap[MAX_LOGICAL_DRIVES_DYN];
>  } __packed;
>  
> With that added, I get zero changes to the executable code.
> 
> I assume the others need adjustment too.

Interesting... OK, let me refresh my memory about the whole thing
and be back in a minute.

--
Gustavo
