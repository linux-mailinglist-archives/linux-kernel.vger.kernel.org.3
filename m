Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB1D4F4A03
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453417AbiDEWdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388711AbiDENc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:32:57 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED00F5DE7F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:34:26 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 235CYH0u099060;
        Tue, 5 Apr 2022 07:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649162057;
        bh=JBTQpzbP72ROzzwlT8NhQDrUfP1RBqzG2+BjUn/g6Do=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=KwgVbuVcWyxfIZ+4pGRHsr8xUf+IpgKaPnSsiVFSF2Rncegc7Lxe8dL78ITJoErA7
         yIKAbFPV/RUnVYDDL9qqphedyyE22iICSA/rvG3UgKx6eh8bBk8mHWA7KliU/KYXph
         HnjANKc6RS1fbzaZQM3uhDqrA8vvjxUBRKy3cT2Y=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 235CYHx1105259
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Apr 2022 07:34:17 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 5
 Apr 2022 07:34:17 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 5 Apr 2022 07:34:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 235CYHbc106836;
        Tue, 5 Apr 2022 07:34:17 -0500
Date:   Tue, 5 Apr 2022 07:34:17 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Julia Lawall <julia.lawall@inria.fr>
CC:     Nicolas Palix <nicolas.palix@imag.fr>,
        <linux-kernel@vger.kernel.org>, <cocci@inria.fr>,
        Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH] coccinelle: api/stream_open: Introduce metavariables for
 checks
Message-ID: <20220405123417.n6mdou64qidgsfo5@doing>
References: <20220404215926.14811-1-nm@ti.com>
 <alpine.DEB.2.22.394.2204050816560.2185@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2204050816560.2185@hadrien>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08:17-20220405, Julia Lawall wrote:
> 
> 
> On Mon, 4 Apr 2022, Nishanth Menon wrote:
> 
> > Coccinelle spatch version 1.1.1 reports the following:
> > warning: line 134: should no_llseek be a metavariable?
> > warning: line 141: should noop_llseek be a metavariable?
> > warning: line 223: should nonseekable_open be a metavariable?
> > warning: line 290: should nonseekable_open be a metavariable?
> > warning: line 338: should nonseekable_open be a metavariable?
> >
> > So, introduce the metavariable similar to other check instances.
> 
> This changes the semantic from matching the specific thing to anything.
> So are you sure that it is what is wanted?  If it should always be the
> specific thing, then you can get rid of the warning using eg symbol
> no_llseek.

Aaah thank you. Will post a v2 with s/identifier/symbol. I still need to
grok the nuance between the two in [1]. Thanks for clarifying.

[...]

[1] https://coccinelle.gitlabpages.inria.fr/website/docs/main_grammar.html
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
