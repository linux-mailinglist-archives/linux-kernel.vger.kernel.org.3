Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8AD538FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 13:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343762AbiEaLg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 07:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343661AbiEaLgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 07:36:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 330589B1A4
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:36:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1F6B23A;
        Tue, 31 May 2022 04:36:13 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B8793F73D;
        Tue, 31 May 2022 04:36:13 -0700 (PDT)
Date:   Tue, 31 May 2022 12:36:07 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] firmware: arm_scmi: Fix pointers arithmetic in Base
 protocol
Message-ID: <YpX9K3x2zoToVy+3@e120937-lin>
References: <20220530115237.277077-1-cristian.marussi@arm.com>
 <20220530115237.277077-2-cristian.marussi@arm.com>
 <1cdf5131-a67b-7297-ad75-49b53f2da293@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cdf5131-a67b-7297-ad75-49b53f2da293@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 12:02:53PM +0100, Robin Murphy wrote:
> On 2022-05-30 12:52, Cristian Marussi wrote:
> > Fix a possible undefined behaviour involving pointer arithmetic in Base
> > protocol scmi_base_implementation_list_get().
> > 
> > cppcheck complains with:
> > 
> > drivers/firmware/arm_scmi/base.c:190:19: warning: 't->rx.buf' is of type 'void *'. When using void pointers in calculations, the behaviour is undefined. [arithOperationsOnVoidPointer]
> >   list = t->rx.buf + sizeof(*num_ret);
> 
> Except we use GNU C, where it is well-defined[1]. We use void pointer
> arithmetic *all over* Linux, so there really isn't any valid argument that
> it could be problematic. If this was a common SCMI library intended to be
> portable then the patch would seem more reasonable, but in Linux-specific
> driver code it's just pointless churn.
> 

Hi Robin,

thanks for the correction, I'll drop this.

Thanks,
Cristian

> Cheers,
> Robin.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Pointer-Arith.html
> 
> > Fixes: b6f20ff8bd94 ("firmware: arm_scmi: add common infrastructure and support for base protocol")
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >   drivers/firmware/arm_scmi/base.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
> > index 20fba7370f4e..6d6214d9e68c 100644
> > --- a/drivers/firmware/arm_scmi/base.c
> > +++ b/drivers/firmware/arm_scmi/base.c
> > @@ -187,7 +187,7 @@ scmi_base_implementation_list_get(const struct scmi_protocol_handle *ph,
> >   	num_skip = t->tx.buf;
> >   	num_ret = t->rx.buf;
> > -	list = t->rx.buf + sizeof(*num_ret);
> > +	list = ((u8 *)t->rx.buf) + sizeof(*num_ret);
> >   	do {
> >   		size_t real_list_sz;
