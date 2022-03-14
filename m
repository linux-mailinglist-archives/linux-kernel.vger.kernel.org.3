Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DA94D79BB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 04:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbiCNDrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 23:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbiCNDrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 23:47:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038022019B;
        Sun, 13 Mar 2022 20:46:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEACFB80B01;
        Mon, 14 Mar 2022 03:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D71C340E9;
        Mon, 14 Mar 2022 03:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647229592;
        bh=9CffuTNQUaMUmjqmJch5cZlo4q/gGksVZbh40A3Psuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W46ewqL7DOEXG23covLPSNlxGH08m7QBbMKyzgvbkX0+USSE0TIN78sXSvrf8x6jz
         PWsObOxMPMoP/Y3/qTByz/AS5RHtaW/gBlmUpMm4w19Tv+BSEYyzwH2NnVKmKygLYP
         GGGjNIE78syrJu7LI9aIL0o+in9CHfV+u3PBtsfaIRMe4xKP6f5J4gNvjExp1/7Z6Y
         UIvEUgIKICe3vLSvmTF4FlR8pkt3x9KqKgbjG5Mm+L8egoVbhvms5tP19IdW0WpztF
         GQ29lYU3nzaaUn5+0BivBTjztY1lYhucX1W3B3eZJ1zJjWTSs9aiA+nWYudaqg50ou
         gTkl421aOhMpg==
Date:   Mon, 14 Mar 2022 05:45:45 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Message-ID: <Yi66abN6kg/8DGzi@iki.fi>
References: <YhLhoMFPyOFZ2fsX@iki.fi>
 <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <YimWaAqEnXHbLdjh@iki.fi>
 <op.1itu5vkewjvjmi@hhuan26-mobl1.mshome.net>
 <Yis8LV99mORcLYs6@iki.fi>
 <Yis9rA8uC/0bmWCF@iki.fi>
 <97565fed-dc67-bab1-28d4-c40201c9f055@intel.com>
 <YiuQx+X9UQ2l22un@iki.fi>
 <e1c04077-0165-c5ec-53be-7fd732965e80@intel.com>
 <Yi65sM+yCvZU0/am@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi65sM+yCvZU0/am@iki.fi>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 05:42:43AM +0200, Jarkko Sakkinen wrote:
> On Fri, Mar 11, 2022 at 11:28:27AM -0800, Reinette Chatre wrote:
> > Supporting permission restriction in an ioctl() enables the runtime to manage
> > the enclave memory without needing to map it.
> 
> Which is opposite what you do in EAUG. You can also augment pages without
> needing the map them. Sure you get that capability, but it is quite useless
> in practice.

Essentially you are tuning for a niche artifical use case over the common
case that most people end up doing. It makes no sense.

BR, Jarkko
