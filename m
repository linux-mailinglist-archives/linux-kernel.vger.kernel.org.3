Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3722B5A8602
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbiHaSpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiHaSpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:45:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61A524099;
        Wed, 31 Aug 2022 11:45:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DBFEB8228E;
        Wed, 31 Aug 2022 18:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F29C433C1;
        Wed, 31 Aug 2022 18:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661971537;
        bh=qAHNrcYfEDyfMgs5fBUxKc1wk7bG++KpzqG+Hbijn5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ceAGAfVXt+jzwJe2rqQnjMjP3JP0l6t9eqAnw3VsOdGXcdmZFs2HNJo8L/X3FKnHK
         oWglRtcC3I7eEGEIijdONoTQIqTOuiICb+i3PiIuMgwGTFQdnCG58wRFo3GD22cgbK
         BIMyeGzSO99V2e+XT5Wz8g4LfrmXwMGtwAn0XykOgPVz4QPQAzHNyKjdX4F8l8R1P9
         eUDWwpqt8ThA15MniJTKZ17MRMzhMG3/0pgJEpkKnlGVlnuQgRPdqOGq9UCYZfgsjv
         /wPiMDYXprM2AaSUkQ54jmAHrNPtPzYSRpx0SB3YhF+c6m8Gi/enQDiLfSWbP5/msE
         DLmZ+d4A9cyoQ==
Date:   Wed, 31 Aug 2022 21:45:32 +0300
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
Message-ID: <Yw+sTOGSSor7QzPi@kernel.org>
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

Sure, sorry about that.

BR, Jarkko
