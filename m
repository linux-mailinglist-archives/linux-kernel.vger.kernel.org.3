Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE1B57AB42
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 03:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbiGTBAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 21:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237782AbiGTBAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 21:00:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A295BE1C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 18:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2098616C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B573C341C6;
        Wed, 20 Jul 2022 01:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658278820;
        bh=MZtKfagM8+72BppuxKbSGdo9k6jyCRC8pRCxiHBt1i4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HLN3jgdj3/8SBUDa3DyPZo1lQNWziWEO9t+bHba9UtZ2HdB3KO89g7V1+hMRAM006
         u7KX5ZB9nY0JF26g6j2TcHEzGwC8uqu6mNA8TQT/8LeN3RCul6yD8ThqD9rAL96acT
         sUc5C614do0NgXgP7DW0MmBI2eP1kG5QWcJtBk7QA2loCpDP6Rx4qaiAE222MHC1dR
         TQbwW7pqre6eEjAF5VBr7KuCX6UZUg152NQNSf07zB2a29awfrAb3aycDKp1NoJ7p4
         GjVf2IO6Y58GeDN4EeKpo1MISm6k4EG4Htv/j3Xc7qLqfTKcrTUTcbTtJDZsejXSVr
         8uHoTPkSdTzfw==
Date:   Wed, 20 Jul 2022 01:00:16 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/10] platform/chrome: cros_kunit_util: add default
 value for `msg->result`
Message-ID: <YtdToLP3Ban3nMDM@google.com>
References: <20220718050914.2267370-1-tzungbi@kernel.org>
 <20220718050914.2267370-2-tzungbi@kernel.org>
 <CABXOdTfYAGapjkPxRC4SbKMKEwCWmrF46aEDFWvsMBqaTuCzPA@mail.gmail.com>
 <YtYsXvi9WfdLFCiu@google.com>
 <CABXOdTf3zGf+pKFPeCXLeAX2t01Euf9enUUSuHq___Y+WFcWUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTf3zGf+pKFPeCXLeAX2t01Euf9enUUSuHq___Y+WFcWUA@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 02:27:49PM -0700, Guenter Roeck wrote:
> On Mon, Jul 18, 2022 at 9:00 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > On Mon, Jul 18, 2022 at 06:35:42AM -0700, Guenter Roeck wrote:
> > > On Sun, Jul 17, 2022 at 10:10 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > > > +int cros_kunit_ec_xfer_mock_default_result;
> > > > +EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_default_result);
> > >
> > > Is this needed as a global variable and, if so, does it really have to
> > > be exported ?
> > >
> > > >  int cros_kunit_ec_xfer_mock_default_ret;
> > > >  EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_default_ret);
> > >
> > > Same here, really, only I didn't notice before.
> >
> > Global variables: I'm afraid yes.  They should be accessible to test cases
> > (e.g. drivers/platform/chrome/cros_ec_proto_test.c).
> >
> 
> Hmm, I don't see where that is used. Either case, even if the
> variables are supposed to be used from cros_ec_proto_test.o, I don't
> see why cros_ec_proto_test.o and cros_kunit_util.o need to be separate
> modules. Can you combine them into a single module ? That would avoid
> the exports.

Ack.  I realized these shouldn't be in current series.  Will separate them
into an indepedent series.
