Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C954DBCAF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358365AbiCQBwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbiCQBwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:52:33 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DA5140FB;
        Wed, 16 Mar 2022 18:51:18 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bu29so6763542lfb.0;
        Wed, 16 Mar 2022 18:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r4E837av3GEkT1qW1jpjXNfbYr30LcsFLqr+mfuO7kI=;
        b=M1OooYYfw9BSCfTSNFcgMHAiPRL5YFnto2cRrIOhbc8TGNNIIZAKbBHM4+llfK7yY+
         MT+uUc48HAOACA5KBiPh3jWIGjBPjG1J8NHiitP4ggDa9djiKHh3H3acEjHfR4MUiWo1
         xIE+pek0wami4eGEnA4ePE6mEm/OTlxvhTW+hjsWLO7UQhMDti8ypnErVd+kkKDJnR7q
         pVcloMESpSO05TXdVfZ2pTbqMvNvtBE7xhWZAsvdW9esn0avaPdpP4El8NI6THST4DcW
         vMQys0xqrCs7llv+JB+hZlOdflIKu+afzCYQUAjWhiKvk6BTNJXr5IpohVjgOYTBbFa4
         zG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4E837av3GEkT1qW1jpjXNfbYr30LcsFLqr+mfuO7kI=;
        b=vb7zxnnqKwZw040qR9jJeCtELM26HgTtahRozLvhbXlAuLGZc8m+Zk2LwvQhdpCXqI
         KNQd2OpJRSH5JZDkWxp0ipd7Bq5K9+Dqj9qb6ixi5fKAhm8xSpoyE86Wh3nkDQqBV+6D
         k5I8xw8YZbW1SyDTuxcL2dA/SN+71WOJt77vJ7TIkbmtJ5sQs9k8y/WY3dgdbd4IKlrt
         yGSuRKClIcPbACcrIHYxwTh61bzw1NczqvE/6SyLhs44Rt0lpA8zO2/zhcAG5tqfk5W9
         phXHeGuIz3pGaZLSocyaFqAy4hcENa61pAr+GO/eeK41r9R6tOfd+Png6sI058Tjt/rY
         ppPg==
X-Gm-Message-State: AOAM533eJsWOVAgsu08QJnyFrjtvyc3nAeQLW8mlJUJGg7fm66L0jrFK
        jmjdFBvZNOVOWIEkpxiaqaRAMBCjmF9VI7I4HUMHjuZt
X-Google-Smtp-Source: ABdhPJwbTzCTkxZMnP3PAx3eirbIfZXngNsD5OU6F25AFOCc0j6FKXLeozR5ecJos4ZtXVU0p84hRZAd0pz32cQezmo=
X-Received: by 2002:a05:6512:3f09:b0:43a:4463:56f9 with SMTP id
 y9-20020a0565123f0900b0043a446356f9mr1360376lfa.533.1647481876197; Wed, 16
 Mar 2022 18:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <3c576edf-89c3-ccf3-a43f-4ce2c1ced18d@zhaoxin.com>
 <Yi7xJy70XZCA8RyN@kroah.com> <CAL411-o_2PSndEVXfa+ciLukSr5u5w8G9T63d2MpSm2Fpn5QTQ@mail.gmail.com>
 <d95ca5f6-221b-1a22-abbe-10621e2fb219@linux.intel.com>
In-Reply-To: <d95ca5f6-221b-1a22-abbe-10621e2fb219@linux.intel.com>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Thu, 17 Mar 2022 09:51:01 +0800
Message-ID: <CAL411-pJt2mZFeE_mkGrA68VhkG237FYwCEUY9FTr6ptUQNd_Q@mail.gmail.com>
Subject: Re: [PATCH] USB: Fix xhci ERDP update issue
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>,
        mathias.nyman@intel.com, Alan Stern <stern@rowland.harvard.edu>,
        USB list <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, CobeChen@zhaoxin.com,
        TimGuo@zhaoxin.com, tonywwang@zhaoxin.com, weitaowang@zhaoxin.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 8:43 PM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 16.3.2022 13.57, Peter Chen wrote:
> > On Mon, Mar 14, 2022 at 10:34 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >>
> >> On Mon, Mar 14, 2022 at 03:25:23PM +0800, WeitaoWang-oc@zhaoxin.com wrote:
> >>> On some situations, software handles TRB events slower than adding TRBs,
> >>> xhci_irq will not exit until all events are handled. If xhci_irq just
> >>> handles 256 TRBs and exit, the temp variable(event_ring_deq) driver records
> >>> in xhci irq is equal to driver current dequeue pointer. It will cause driver
> >>> not update ERDP and software dequeue pointer lost sync with ERDP. On the
> >>> next xhci_irq, the event ring is full but driver will not update ERDP as
> >>> software dequeue pointer is equal to ERDP.
> >
> > At the current driver, the ERDP is updated at most 128 TRBs, how is
> > the above condition
> > triggered?
> >
> > Peter
> >
>
> Before, and during _one_ interrupt handling xHC hardware writes exactly 256 events
> to event ring. ring buffer size is 256 so buffer position 0 and 256 point
> to the same place.
>
> Interrupt handler stores software dequeue in a local variable "event_ring_deq".
> Handler start handling events, it updates software dequeue, but not local variable.
> After 128 events handler updates hardware ERDP.
>
> So at event 128 we got:
> Hardware ERDP = 128
> software dequeue = 128
> event_ring_deq = 0
>
> Handler continue handling events, at event 256 try to update HW ERDP again, but fail due
> to this condition in update_erst_dequeue():
>       if (event_ring_deq != xhci->event_ring->dequeue)
>
> This fails because event_ring_deq is still 0, and software deq is 256,
> pointing to the same place in the event ring.
>
> So at the end of the interrupt handler we have:
> HW ERDP = 128
> software dequeue = 256 (same as 0)
>
> So in this specific case we fail to update ERDP correctly

Cleared, thanks.

Peter
