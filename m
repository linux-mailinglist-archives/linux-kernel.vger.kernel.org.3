Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C029849DF3B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbiA0KXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:23:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36903 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239460AbiA0KWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643278939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1PmCWGvE0rw+ZGEFxB1GG8/3CTt9oGBb3Q0WVUXx7pM=;
        b=QowtFisz6gBMm6NSaGau11RYs943eW9gaC4uPhoF710gRD3uuSLub3T4/4qTPFEbLxr3tv
        uvGbdKDW3efZMixaD8+P08cxFLVAIRsw2HGmIEDDfZTQNpjyKK3aZSgbOPDbmCnbn/9uyD
        t3qK0zOuIcifhtypt/hygiuEQzr9Oqo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517--pHUm6U3P_uReOfqOdUVDw-1; Thu, 27 Jan 2022 05:22:16 -0500
X-MC-Unique: -pHUm6U3P_uReOfqOdUVDw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 815F41F6B0;
        Thu, 27 Jan 2022 10:22:14 +0000 (UTC)
Received: from starship (unknown [10.40.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C50781059119;
        Thu, 27 Jan 2022 10:22:11 +0000 (UTC)
Message-ID: <495878a237748e3652619e692706b9352969f435.camel@redhat.com>
Subject: Re: [PATCH 0/5] iommu/amd: fixes for suspend/resume
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Mike Lothian <mike@fireburn.co.uk>
Cc:     dwmw@amazon.co.uk, iommu@lists.linux-foundation.org,
        joro@8bytes.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, tglx@linutronix.de, will@kernel.org
Date:   Thu, 27 Jan 2022 12:22:10 +0200
In-Reply-To: <CAHbf0-EY9_27Tw3v-pfwXDaTuwpsuuFqrJDKZ8C_cW+-PwXwww@mail.gmail.com>
References: <20211123161038.48009-1-mlevitsk@redhat.com>
         <20220125150832.1570-1-mike@fireburn.co.uk>
         <6f0d9b07073ca6d3657500ec076edc1ad2a3e40a.camel@redhat.com>
         <CAHbf0-FJ0c1yAumKCnXLKKFN=tzeJxSd3HyP=dUOBgBTxVG5fw@mail.gmail.com>
         <7809c3253a997330102b9d779206312d6b3bcaf1.camel@redhat.com>
         <CAHbf0-F8Uemcu8FVcZvY0CPOf4kFXOcaCzWF1ZCwkpa3tyut3A@mail.gmail.com>
         <6cf58a4cd925726ef10481d38f9f4e8090f5023d.camel@redhat.com>
         <CAHbf0-EY9_27Tw3v-pfwXDaTuwpsuuFqrJDKZ8C_cW+-PwXwww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-01-27 at 00:39 +0000, Mike Lothian wrote:
> On Wed, 26 Jan 2022 at 10:12, Maxim Levitsky <mlevitsk@redhat.com> wrote:
> > Great, your system does seem to support GA log
> > (but a patch to check if, other that assume blindly that it is supported is
> > something that should be done).
> > 
> > So could you bump the LOOP_TIMEOUT like by 10x or so and see if the problem goes away?
> > 
> > (that code should be rewritten to time based wait and not just blindly loop like that,
> > I also can prepare a patch for that as well).
> > 
> > Best regards,
> >         Maxim Levitsky
> > 
> 
> Hi
> 
> I've done quite a few restarts with the LOOP_TIMEOUT increased and
> I've not seen the issue since

Great, so the problem is solved I guess. 
Thanks for the help!


I'll send a patch for this in few days to replace this and other similiar timeouts
with a proper udelay() wait.

Best regards,
	Maxim Levitsky

> 
> Cheers
> 
> Mike
> 


