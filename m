Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40815A85FD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiHaSoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiHaSof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:44:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B43BD5;
        Wed, 31 Aug 2022 11:44:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D994160E89;
        Wed, 31 Aug 2022 18:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8099C433D6;
        Wed, 31 Aug 2022 18:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661971473;
        bh=bXVzGMvvGTEaLDHMeK2hMUd2osC7vq1ST9RgLI8qV5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YfRKBl2tseu5V+P2/pvJuHp+UPI5ey31PwfQxSywuqpZGSi40WnEajFVRczC8P4zN
         gXoHdizqUUk1IuSeLKKOVuoXEoRthT8H01oQVuH4xVglQI7HwDTHFzsYPTxXQjQMGi
         1PTmzW4XFF/SBWsBrCRwuVo+MD5m2p8+2LMtVKtNg67gYmBDOID2KOyVaRNx0epJi0
         ASEz6LAyypQBHuV7oPBehmEOu+KvuFSTaL4Miw428vBKGXp0x/uBpH63okNpvCFrpN
         b2+eMsGdVpCURl7biAfJIGMDRkhxdsoY+wBfIfyF/wbs6cm0jvbKxSs5PvMIHt3MA1
         VfHplgSNet7ww==
Date:   Wed, 31 Aug 2022 21:44:28 +0300
From:   "jarkko@kernel.org" <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Message-ID: <Yw+r8zLoq3pviDIc@kernel.org>
References: <1b3308a364317d36ad41961ea9cfee24aa122f02.camel@intel.com>
 <Yw7EX5GCrEaLzpHV@kernel.org>
 <d07577c3f0b4b3fff0ce470c56f91fb634653703.camel@intel.com>
 <Yw7LJa7eRG+WZ0wv@kernel.org>
 <c3c085d69311ed759bff5bb325a2c182d423f91f.camel@intel.com>
 <Yw7OEh7QP8tb7BR1@kernel.org>
 <a91f65ad5c392b6e34f07bc6d3f35c89a76a98db.camel@intel.com>
 <op.1rrt4aecwjvjmi@hhuan26-mobl1.mshome.net>
 <Yw+oR3FKlwbeOl6I@kernel.org>
 <ea61a9ee-96dc-4f23-9de3-34e033391abc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea61a9ee-96dc-4f23-9de3-34e033391abc@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 11:35:10AM -0700, Dave Hansen wrote:
> Jarkko, Kai and Haitao,
> 
> Can you three please start trimming your replies?  You don't need to and
> should not quote the entirety of your messages every time you reply.
> 
> On 8/31/22 11:28, jarkko@kernel.org wrote:
> >> Will it cause racing if we expose dev nodes to user space before
> >> ksgxd is started and sensitization done?
> > I'll to explain this.
> > 
> > So the point is to fix the issue at hand, and fix it locally.
> > 
> > Changing initialization order is simply out of context. It's
> > not really an argument for or against changing it
> > 
> > We are fixing sanitization here, and only that with zero
> > side-effects to any other semantics.
> > 
> > It's dictated by the development process [*] but more
> > importantly it's also just plain common sense.
> 
> Kai, I think your suggestion is reasonable.  You make a good point about
> not needing ksgxd for vepc.
> 
> *But*, I think it's a bit too much for a bugfix that's headed to
> -stable.  I'm concerned that it will have unintended side effects,
> *especially* when there's a working, tested alternative.

Yeah, I also actually *do* agree that the suggestions could
be reasonable.

BR, Jarkko
