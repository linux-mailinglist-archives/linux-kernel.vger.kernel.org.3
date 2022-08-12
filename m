Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E31A5911FE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 16:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239160AbiHLOOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 10:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239149AbiHLOOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:14:05 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6F5A220D
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:14:02 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id j11so675104qvt.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=GW+R/AahzASb8bKxwUt/1m6w7iLY/SiHi7x7jOCzoTM=;
        b=S+XCCCgXogBEhL8L+DhY4RDV1J5HkndLrJa8Ci47GCDxN2G09fylPR/TXON1UKtHpG
         azCOnLzy9cAmJAWijB5iFXIAHCZq8KvxbH2gkHSFrJA7Wca0DVaK0EZZIaVNf196mn57
         LZ2Ut7NwW+NsG9Vi8MD/5DOX80W7wKp2IoIPwq7gmUSZ+ektfthAWcUzHqHk2gyxnhtm
         EwPfhiYy4F+W8ezYYnqfhA15MPXtmxj+jUpPP4iOkGB/qa+xHAmmKxzp1E516jK58ixn
         /jcPxaH38QDwwdnjDR7j4TmI0geLeFiuh//rpkh+UXoIvTyH4JukJz3RGp6SjcEmU8tN
         J47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=GW+R/AahzASb8bKxwUt/1m6w7iLY/SiHi7x7jOCzoTM=;
        b=nBKVbMdtqk4bujaj0+i93TqL8EsxAGdeBj865uZuILl9ry9wM72D3Hjv46nLt66kpv
         SePETjr24qdGwohL9nVVgQ/dfrNI6HrqvjaVCRAQZ5+SulebflnV3Falw1IH8Ruuq0GJ
         wMotEWX0t0O1/klJAmrFZDey/PrdqboVqpX+PPwF+JjNRJDdx9bzJ7muA885EDPrnSzs
         yRWwoAHqRDO+YDFUg660ufQDg93/ErAq4z6CB4WBQTbieJg1ulnsz8awNDImj6tO53zK
         kg4zMTSZ761LTd0trPFEiywdnAueidjph//ylHGegJqjELDYT27LXj6jSVXTRKj03wB/
         nJxg==
X-Gm-Message-State: ACgBeo3iDvjrRe/PIb2S4EH4YLLLwk66Ab0e6OEq6WInzS3sccF+8MMZ
        sKlkR6sAm3lXwOu9Ti5n/EP6Ng==
X-Google-Smtp-Source: AA6agR6Zvajpjouf2vdOryKpECLajD53/UwCjtRuOVyGVBl0mXfxgfa7+xkPaIplUAbV7LnJ6Bnanw==
X-Received: by 2002:a05:6214:c45:b0:477:46a7:9882 with SMTP id r5-20020a0562140c4500b0047746a79882mr3712623qvj.12.1660313641511;
        Fri, 12 Aug 2022 07:14:01 -0700 (PDT)
Received: from kudzu.us ([2605:a601:a608:5600::59])
        by smtp.gmail.com with ESMTPSA id r2-20020a05620a298200b006b555509398sm1754369qkp.136.2022.08.12.07.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 07:14:00 -0700 (PDT)
Date:   Fri, 12 Aug 2022 10:13:59 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Tom Rix <trix@redhat.com>, kishon@ti.com, lpieralisi@kernel.org,
        kw@linux.com, bhelgaas@google.com, Frank.Li@nxp.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: endpoint: pci-epf-vntb: reduce several globals
 to statics
Message-ID: <YvZgJ4IGEG8levOA@kudzu.us>
References: <20220704132559.2859918-1-trix@redhat.com>
 <20220712200527.GA791291@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712200527.GA791291@bhelgaas>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 03:05:27PM -0500, Bjorn Helgaas wrote:
> On Mon, Jul 04, 2022 at 09:25:59AM -0400, Tom Rix wrote:
> > sparse reports
> > drivers/pci/endpoint/functions/pci-epf-vntb.c:956:10: warning: symbol 'pci_space' was not declared. Should it be static?
> > drivers/pci/endpoint/functions/pci-epf-vntb.c:975:5: warning: symbol 'pci_read' was not declared. Should it be static?
> > drivers/pci/endpoint/functions/pci-epf-vntb.c:984:5: warning: symbol 'pci_write' was not declared. Should it be static?
> > drivers/pci/endpoint/functions/pci-epf-vntb.c:989:16: warning: symbol 'vpci_ops' was not declared. Should it be static?
> > 
> > These functions and variables are only used in pci-epf-vntb.c, so their storage
> > class specifiers should be static.
> > 
> > Fixes: ff32fac00d97 ("NTB: EPF: support NTB transfer between PCI RC and EP connection")
> > Signed-off-by: Tom Rix <trix@redhat.com>
> 
> Handled via Jon, I guess?
> 
> I'm unclear on the future direction of pci-epf-vntb.c.  Jon, are you
> signing up to maintain this?  MAINTAINERS doesn't seem to reflect
> that, even in next-20220712, so you're not being copied on everything.
> 
> If you are planning to merge and maintain this file, it would be
> helpful to me if you acknowledge patches you merge so I know to ignore
> them.

I massively dropped the ball on all the EPF stuff.  I appologize profusely.

I'm pulling it into my ntb tree bcause of the patch dependencies.  If
you want me to own this stuff because it has ntb in it, then I can do
a matainers entry to reflect it.  My assumption is that because it is
under the drivers/pci umbrella it is yours (unless you want me to own
it).  100% defer to your decision.

All that being said...
Sorry for the extremely long delay in response.  This series is in my
ntb branch and will be in my pull request for v5.20 which should be
going out later today.

Thanks,
Jon

> 
> > ---
> > v2,3 : Change commit prefix
> > 
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index ebf7e243eefa..6f0775b1fec3 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -953,7 +953,7 @@ static struct config_group *epf_ntb_add_cfs(struct pci_epf *epf,
> >  
> >  #define VPCI_BUS_NUM 0x10
> >  
> > -uint32_t pci_space[] = {
> > +static uint32_t pci_space[] = {
> >  	(VNTB_VID | (VNTB_PID << 16)),	//DeviceID, Vendor ID
> >  	0,		// status, Command
> >  	0xffffffff,	// Class code, subclass, prog if, revision id
> > @@ -972,7 +972,7 @@ uint32_t pci_space[] = {
> >  	0,		//Max Lat, Min Gnt, interrupt pin, interrupt line
> >  };
> >  
> > -int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val)
> > +static int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val)
> >  {
> >  	if (devfn == 0) {
> >  		memcpy(val, ((uint8_t *)pci_space) + where, size);
> > @@ -981,12 +981,12 @@ int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *
> >  	return -1;
> >  }
> >  
> > -int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val)
> > +static int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val)
> >  {
> >  	return 0;
> >  }
> >  
> > -struct pci_ops vpci_ops = {
> > +static struct pci_ops vpci_ops = {
> >  	.read = pci_read,
> >  	.write = pci_write,
> >  };
> > -- 
> > 2.27.0
> > 
