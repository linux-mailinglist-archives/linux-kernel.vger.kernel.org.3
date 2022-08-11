Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BB1590704
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 21:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbiHKTgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 15:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbiHKTgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 15:36:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B95883DC;
        Thu, 11 Aug 2022 12:36:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 243BF60FF4;
        Thu, 11 Aug 2022 19:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F233BC433C1;
        Thu, 11 Aug 2022 19:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660246578;
        bh=VFDZCqb+1IhthOrU2AnhG14PREmnKQn1Hn8rRS3DcUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mkNi12XLJTAZS+XyEUTx3wbZb+n800pOLn3zi4w7oDn90Fgquo4stiLUuU6sp6ci0
         HmOTwklaoNaROUv1m8dx8FDJD335j7uhNtpHeKIVrRUfOquQv6QKNOGbM63hSwuLrS
         EHyzROVN0masmZLkWFud3XspFRVwMLX1JWXvQSgmxxNIRGOVxvu3TLHTBeJ+EZLj4+
         srE1ZV2HL0wm2ox7EbHLp0AN0k/2hZfiXWeDyqj8TMKRHQvnCb/wuReaJNjFycXnhj
         4jDiw2xxNhf+0kjRpqO05biS4y7MPSblbwZVcJU5MpqYcOr1RTlDWMsS6sS0EpB943
         x9Qp/O0babeOA==
Date:   Thu, 11 Aug 2022 19:36:16 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v6] ufs: core: print UFSHCD capabilities in controller's
 sysfs node
Message-ID: <YvVaMJMPVFc4Sa+I@gmail.com>
References: <20220803074955.v6.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
 <YuoRuP2pxgSQ6c9E@kroah.com>
 <CAONX=-f8kHWCEEyqUdpn5wsyMZKa4eJSSCLvPDn3R5mQF9FSMA@mail.gmail.com>
 <YvSfjwCu69ivTGIZ@sol.localdomain>
 <CAONX=-dK3CA2Tp2z+HrSTrR8=VJQuiFPhgoqKQkLhrDU1JXG5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAONX=-dK3CA2Tp2z+HrSTrR8=VJQuiFPhgoqKQkLhrDU1JXG5A@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 05:32:34AM +1000, Daniil Lunev wrote:
> Hi Eric,
> > This is describing the directory, so please include it in a documentation entry
> > for the directory itself (/sys/bus/platform/drivers/ufshcd/*/capabilities/) just
> > above the documentation entries for the files in the directory.
> 
> Should I keep the comment in this file as well, or remove it here when
> adding to the documentation?
> 
> --Daniil

Avoiding redundancy is nice.  Maybe make the code just refer to the
documentation?

- Eric
