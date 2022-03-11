Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF424D684E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 19:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350789AbiCKSJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 13:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbiCKSJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 13:09:09 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C16443AF3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:08:05 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id z8so10214634oix.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T6tAfBDIbeqr2rX5cz/+B+v+oAUesU8ImGhC1rDQ7lA=;
        b=Z23fpFSaOFDv2bKo6jNWklXN739Cp5FIq+rKAF+f2uye3T6qd45lxtGWLM/KHr1A+w
         0jpfmf4dCqsY0o9ZAn03Un97WioX6gA2ouqXcnilV+2DhZkw2rX6Fa4dZgrhLAKEWl2L
         mfC0SSPKQ/sn/zxCCusOjW8hXykq3TE1MP3WS5Msq5AjKy5H/MaP7JjEbAwBOwt3Rjyq
         S9+m1Mbqptwe7EUvJIWFT5NDCI3aHF7c0EaAaryPQHMlF70HJCb8lzo9BX6eI3/D1ut/
         6s4ZO9WFX0sMAHFvYv7ZMIz6JC6lpjE+qwwCALoBPNdI36phi3oV9I+w5wq1/Gkz0qfi
         /M4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T6tAfBDIbeqr2rX5cz/+B+v+oAUesU8ImGhC1rDQ7lA=;
        b=vWhMraJC3zBA5d0bygafWAuzrnw21LSVN+SAZSNYtBF1vjODuzMTuh9eVd8gS7c5Ws
         59NvtwOWIPVccteddvBKKcsYWPMtu6PU+bmJdGmjw+6UlCgO7D0FJRrEWgPzpwAk5Iwt
         lV/aIrRkXCOY+eeaMfAKZFuaBGzx+Vduhf9iibvH0/lZKoyOkqoEWndBr2XC19lAhUPQ
         grkY0VEp84Eru0ONqN7zgeRmrk14f7AFFDG3Uvusz1MrRnTNql4+WBgH0rByRk93WCqr
         Nz3wirZ/gJuelJGGQWfWKea0UmGC4InHHt2ebWW54J1KQpByUp4Vyg7P4aI9S9hanA/7
         IZcw==
X-Gm-Message-State: AOAM531kceT6r1rmJvMVuCrF+Ko+iPkVbWVZpztAAwhtysJ9BQd0UJrg
        BjjZx8KGgvn9tiX+W4vzcIdw4w==
X-Google-Smtp-Source: ABdhPJzVOnqSRL/7lmpX9k7aXHuUAUBSzyGrOLOd3DPralQG3Til5oHsTJ3SVVxCCZ+IxCKYIg4WMw==
X-Received: by 2002:a05:6808:8ce:b0:2ec:a7ff:4925 with SMTP id k14-20020a05680808ce00b002eca7ff4925mr863487oij.122.1647022084653;
        Fri, 11 Mar 2022 10:08:04 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id h11-20020a9d6f8b000000b005b230ab0461sm3851009otq.64.2022.03.11.10.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 10:08:03 -0800 (PST)
Date:   Fri, 11 Mar 2022 12:08:02 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suman Anna <s-anna@ti.com>, Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH] remoteproc: move rproc_da_to_va declaration to
 remoteproc.h
Message-ID: <YiuQAvnbBIdWhy2l@builder.lan>
References: <20220308172515.29556-1-dfustini@baylibre.com>
 <YiedlvZWpHd8HP40@ripper>
 <YijeDirNSJ6bpRMj@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YijeDirNSJ6bpRMj@x1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09 Mar 11:04 CST 2022, Drew Fustini wrote:

> On Tue, Mar 08, 2022 at 10:16:54AM -0800, Bjorn Andersson wrote:
> > On Tue 08 Mar 09:25 PST 2022, Drew Fustini wrote:
> > 
> > > From: Suman Anna <s-anna@ti.com>
> > > 
> > > The rproc_da_to_va() API is an exported function, so move its
> > > declaration from the remoteproc local remoteproc_internal.h
> > > to the public remoteproc.h file.
> > > 
> > > This will allow drivers outside of the remoteproc folder to be
> > > able to use this API.
> > > 
> > 
> > Can you explain why drivers outside of the remoteproc folder should be
> > able to poke straight into the memory of the remoteproc?
> > 
> > Your reasoning makes sense, but we've on purpose kept it out of
> > remoteproc.h because no one has had a proper reason for it and I sense
> > that we might open the door for some new creative solutions...
> 
> rproc_da_to_va() is used in a patch for drivers/soc/ti/wkup_m3_ipc.c
> that adds support for i2c voltage scaling [1].
> 
> wkup_m3_copy_aux_data() will copy auxiliary data to special region of
> the Cortex M3 memory. It calls rproc_da_to_va() to get aux_data_addr
> which is then used as a memcpy destination.
> 

So in essence it's an essential part for the "communication protocol"
used to communicate with the remoteproc...

> Does that seem like a reasonable way to do it?
> 

I have a concern about the life cycle of the pointer acquired by this
"independent" driver. But this is an extension of my existing concern
where the wkup driver uses the remoteproc core as a "firmware loader",
but it's not a standalone remoteproc driver.

I think it would have been nicer to model the remoteproc driver as the
parent of the wkup device, so we probe/remove the wkup device based on
the state of the remoteproc.

This would remove concerns about races between the remoteproc
starting/stopping/restarting and the other driver and it would help
clarify that the life cycle of the pointer returned by rproc_da_to_va()
lives from start to stop of the remoteproc.


This does however not change the need for exporting the symbol, so I'm
merging this patch.

Regards,
Bjorn

> I was going to submit the i2c voltage scaling patches later. However,
> I could combine them into a series with this remoteproc patch if that
> helps to justify the remoteproc.h change.
> 
> Thanks,
> Drew
> 
> [1] https://lore.kernel.org/linux-omap/20220219215328.485660-9-dfustini@baylibre.com/
