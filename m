Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6368646D8CF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbhLHQuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhLHQuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:50:13 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5E5C061746;
        Wed,  8 Dec 2021 08:46:41 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id a11so2457790qkh.13;
        Wed, 08 Dec 2021 08:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XosRX9BrYERg80bz9IMhw/CrWno39TYz6hMF/OvkCvE=;
        b=RW3twZxBHXO432mj5+mcVltmM2nVwTnuvSxu+Mp3+XDO4R0urf1OXYCFSpuBpvvyz1
         OGeUHlhe0AzKeWJ+itshIejq+K9xGNQ+pSeIYpAwmjv8greLD/IXXwx03wLXgCBsFoxb
         sEqxoV00pcDBpFZ0WIckLdCovArQrzsoU5/KC/xWO7n/Bb/fltK2cG+gzAVnm66HOve4
         ke0AMfersCQyJXBJkzt/VJBHTMUYvEfbMkhkFvuNVWJZdgmzcDLJX6F1BwQCbTzBW4Lh
         cnN2dlV3oFWHN70DM0u+nMrpVgDcQsl6Cvf5zSj7c8XJ5dIVMWVhQF5nQB0XJmxlGrVJ
         EuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XosRX9BrYERg80bz9IMhw/CrWno39TYz6hMF/OvkCvE=;
        b=2BWyaARMTL1KQMy8vW3WOtPK2UsTbg78SXyLPKhtFyOYePvI+Fedxt0vuR7+3DJp9f
         /95OeNrW18Hf++O559IyxChsyUrUfaJ3TuxuVI3OGoHEmoae9O4uAVy2xFKk+qQ0D3FS
         5DgPuzRfsvOCWDQNokmbVUCL9MKwG70vD1ikBlpRTCjpKmkQdeLqLQ7YrPL4RFEMKlsh
         VMLNQkOK3bHAgmuzba24GLsdRaKLm3aE1niXvF4SJOjSqSSjT/aKZn3bNpYhpEWaqXFH
         bpNqQ/dBeah7ri++oMbtqRvCbvvdz3mNLnOIpProBwnHd6jFv3rUZ+x5GEEB0X+DRXIu
         gXsA==
X-Gm-Message-State: AOAM532mPX9Czov6wf2Azjm/eHj9959egKtJrlueNowaRqU77phwPltH
        Bp1/R75MJZWUlp6o5uYAytI=
X-Google-Smtp-Source: ABdhPJwvBieDfLBstnCreOHQsEo4o8jK9MKH4ZxOAZ+KYirDvoIpbwWH/cLvuiyrqZiygbyNJv8Jtg==
X-Received: by 2002:a37:883:: with SMTP id 125mr8177576qki.661.1638982000226;
        Wed, 08 Dec 2021 08:46:40 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id d15sm1931575qtd.70.2021.12.08.08.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 08:46:39 -0800 (PST)
Date:   Wed, 8 Dec 2021 11:46:36 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com,
        Paul Mackerras <paulus@ozlabs.org>,
        Stafford Horne <shorne@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>
Subject: Re: [PATCH v1 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <YbDhbLnZVUhw/mz4@errol.ini.cmu.edu>
References: <20211203234155.2319803-1-gsomlo@gmail.com>
 <20211203234155.2319803-4-gsomlo@gmail.com>
 <CACPK8XfO_8=vgedmZddz1YmWbyxiM1-azF_j88wEBHzXnP6y_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XfO_8=vgedmZddz1YmWbyxiM1-azF_j88wEBHzXnP6y_g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On Mon, Dec 06, 2021 at 10:53:17AM +0000, Joel Stanley wrote:
>  On Fri, 3 Dec 2021 at 23:42, Gabriel Somlo <gsomlo@gmail.com> wrote:
> > +static void
> litex_request> +litex_request(struct mmc_host *mmc, struct mmc_request *mrq)
> > +{
> > +       struct litex_mmc_host *host = mmc_priv(mmc);
> > +       struct platform_device *pdev = to_platform_device(mmc->parent);
> > +       struct device *dev = &pdev->dev;
> > +       struct mmc_data *data = mrq->data;
> > +       struct mmc_command *sbc = mrq->sbc;
> > +       struct mmc_command *cmd = mrq->cmd;
> > +       struct mmc_command *stop = mrq->stop;
> > +       unsigned int retries = cmd->retries;
> > +       int status;
> > +       int sg_count;
> > +       enum dma_data_direction dir = DMA_TO_DEVICE;
> > +       bool direct = false;
> > +       dma_addr_t dma;
> > +       unsigned int len = 0;
> > +
> > +       u32 response_len = litex_response_len(cmd);
> > +       u32 transfer = SDCARD_CTRL_DATA_TRANSFER_NONE;
> > +
> > +       /* First check that the card is still there */
> > +       if (!litex_get_cd(mmc)) {
> > +               cmd->error = -ENOMEDIUM;
> > +               mmc_request_done(mmc, mrq);
> > +               return;
> > +       }
> > +
> > +       /* Send set-block-count command if needed */
> > +       if (sbc) {
> > +               status = send_cmd(host, sbc->opcode, sbc->arg,
> > +                                 litex_response_len(sbc),
> > +                                 SDCARD_CTRL_DATA_TRANSFER_NONE);
> > +               sbc->error = litex_map_status(status);
> > +               if (status != SD_OK) {
> > +                       host->is_bus_width_set = false;
> > +                       mmc_request_done(mmc, mrq);
> > +                       return;
> > +               }
> > +       }
> > +
> > +       if (data) {
> 
> This is a big ol' if(). Consider splitting it (or some of it?) out
> into some other functions to make it easier to read.
> 

I can factor out the dma transfer portion into a dedicated helper
function:

   static void litex_mmc_data_dma_transfer(struct litex_mmc_host *host,
                                           struct mmc_data *data,
                                           unsigned int *len,
                                           bool *direct,
                                           u8 *transfer)

where `len`, `direct`, and `transfer` are passed in as pointers,
because the helper function modifies their values and the caller
(i.e., `litex_[mmc_]request()`) is subsequently using those
potentially modified-by-the-callee values.

If you still feel the extra call overhead is worth the tradeoff in
improved legibility and code grouping, let me know and I can have it
out in version 4 (I sent out v3 earlier this morning without changing
this part).

Thanks,
--Gabriel
