Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7C6533F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238199AbiEYOeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237558AbiEYOeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:34:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F498A7E20;
        Wed, 25 May 2022 07:34:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F419F6195D;
        Wed, 25 May 2022 14:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B91C385B8;
        Wed, 25 May 2022 14:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653489251;
        bh=jKMXS9Z2wSf/iYiPIqP+VUf/M/S8DyVS0usjv1+qV2c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ltGVKF9ILk+J3qDoXXxbOxuefxDlIeGH5cypEsKhRPY5BnK8naQBWLrJn1aWrkPny
         HcqttzfzqxJilDJv+SOlZl4pTjpU+vwO5RCUmd9Yw+yQaOCjZ6W9AH+7VXbI8X2X2p
         hwem9EMNKPwJ3vW+IW0uTscg+pY1KKTtZp5TIceRFt6eNSzGW+UZsiCt22qcRP+OV/
         eZLIAszeyj+0rWh0zPUPkwZySV7RgtOxnHt+hYHF+ggHwtWIMSq7Gb4XbUwAfNVaSI
         chxWV3rYlzngrCzUkeOZvYKJMHmjz4L9L9t1wmTuyCS3c7vfToXNFBM9TDRP8yOSaJ
         QSjcECuuOlYew==
Date:   Wed, 25 May 2022 09:34:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>, llvm@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/2] linux/types.h: Remove unnecessary __bitwise__
Message-ID: <20220525143409.GA292780@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5c0a68d-8387-4909-beea-f70ab9e6e3d5@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 08:51:29AM +0200, Jiri Slaby wrote:
> On 15. 03. 22, 16:30, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > There are no users of "__bitwise__" except the definition of "__bitwise".
> > Remove __bitwise__ and define __bitwise directly.
> > 
> > This is a follow-up to 05de97003c77 ("linux/types.h: enable endian checks
> > for all sparse builds").
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   include/uapi/linux/types.h  | 5 ++---
> >   tools/include/linux/types.h | 5 ++---
> >   2 files changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/uapi/linux/types.h b/include/uapi/linux/types.h
> > index f6d2f83cbe29..71696f424ac8 100644
> > --- a/include/uapi/linux/types.h
> > +++ b/include/uapi/linux/types.h
> > @@ -20,11 +20,10 @@
> >    */
> >   #ifdef __CHECKER__
> > -#define __bitwise__ __attribute__((bitwise))
> > +#define __bitwise	__attribute__((bitwise))
> >   #else
> > -#define __bitwise__
> > +#define __bitwise
> >   #endif
> > -#define __bitwise __bitwise__
> 
> Hi,
> 
> this broke userspace, like open-iscsi:
> > [   34s] In file included from session_info.h:9,
> > [   34s]                  from iscsi_util.c:38:
> > [   34s] ../include/iscsi_proto.h:66:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'itt_t'
> > [   34s]    66 | typedef uint32_t __bitwise__ itt_t;
> > [   34s]       |                              ^~~~~
> 
> It looks like we need __bitwise__ back.

Crap, sorry.  I don't know why I thought it would be safe to remove
something from uapi.  I'll send a revert.

Bjorn
