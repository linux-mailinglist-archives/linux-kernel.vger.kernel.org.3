Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666CF56CAB8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 18:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiGIQq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 12:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiGIQqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 12:46:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B24120A4;
        Sat,  9 Jul 2022 09:46:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E0CB60F40;
        Sat,  9 Jul 2022 16:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63481C3411C;
        Sat,  9 Jul 2022 16:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657385214;
        bh=nhQge+HRyXaWCUN57TcS9nHh2S2Nlsi4P8r8FUfHZHE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U3gePJoxxzBd3VmKhoooo4vix4ueROdXcwSJeiOMejhROwk1Dp+LBKuYpNhR0uAMR
         D3g7Gdvb4ifwK2cnb24+KMWWKGXoLBqXPmHDWmG2jQNuVV7utHp/+k6fk/uSBleidv
         oSTkB+6cf5/h1Y8RKLh6XcTOczUFlMnTn2W6qKAHqfJz4eyJNMSWungD2Wa0kcWbJm
         zX0ui4hWIL7sL8SQmIP74noOe23quRTiuMWDKno7y66XV43VKvBMTUywrXailxyT22
         70eGVTdLGfiFbQmXBLTnG9aAZhh77fXkaUf8XyDtzSQCRR5c4OZAclkwQMBIha90t2
         3ncYRd+fq4Eng==
Date:   Sat, 9 Jul 2022 17:46:45 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Martiros Shakhzadyan <vrzh@vrzh.net>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RESEND PATCH 0/3] staging: media: atomisp: Convert to
 kmap_local_page()
Message-ID: <20220709174645.080fc795@sal.lan>
In-Reply-To: <becfe58a-b4c3-4ae1-4ab2-456057ac7d22@redhat.com>
References: <20220707200718.26398-1-fmdefrancesco@gmail.com>
        <becfe58a-b4c3-4ae1-4ab2-456057ac7d22@redhat.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 8 Jul 2022 17:55:26 +0200
Hans de Goede <hdegoede@redhat.com> escreveu:

> Hi,
> 
> On 7/7/22 22:07, Fabio M. De Francesco wrote:
> > After waiting months, I'm resending three conversions to
> > kmap_local_page(). I'd like to ask if there is anything which prevents
> > these patches from being accepted.
> > 
> > Please note that these patches were submitted on April 2022.
> > 
> > For you convenience here are the links to the patches, the "Reviewed-by:" 
> > and "Tested-by:" tags:
> > 
> > [PATCH] staging: media: atomisp: Use kmap_local_page() in hmm_store()
> > https://lore.kernel.org/lkml/20220413225531.9425-1-fmdefrancesco@gmail.com/
> > https://lore.kernel.org/lkml/Yli+R7iLZKqO8kVP@iweiny-desk3/
> > https://lore.kernel.org/lkml/2d096f20-dbaa-1d49-96e9-a7ae6c19f7fe@redhat.com/
> > 
> > [PATCH] staging: media: atomisp: Use kmap_local_page() in hmm_set()
> > https://lore.kernel.org/lkml/20220413212210.18494-1-fmdefrancesco@gmail.com/
> > https://lore.kernel.org/lkml/YldNhErgt53RqYp7@iweiny-desk3/
> > https://lore.kernel.org/lkml/0b04ad1a-e442-1728-ef2c-bab386a4c64c@redhat.com/
> > 
> > [PATCH] staging: media: atomisp: Convert kmap() to kmap_local_page()
> > https://lore.kernel.org/lkml/20220408223129.3844-1-fmdefrancesco@gmail.com/
> > https://lore.kernel.org/lkml/b0aed731-b56f-4378-b50e-fc0cbccbdb84@redhat.com/
> > 
> > Fabio M. De Francesco (3):
> >   staging: media: atomisp: Convert kmap() to kmap_local_page()
> >   staging: media: atomisp: Use kmap_local_page() in hmm_set()
> >   staging: media: atomisp: Use kmap_local_page() in hmm_store()  
> 
> Thanks, the entire series looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Yesterday, I applied all pending patches at media-stage, including those. 
Please check if  everything is ok, as I had to solve some trivial 
conflicts.

Regards,
Mauro
