Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED254EDED6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 18:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239975AbiCaQec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 12:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239969AbiCaQe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:34:29 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57751FF433
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:32:41 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t25so127926lfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b5EuL+gbnNFQ87YRYoAKBwPNNldsvEmstfa9tdC1Qjw=;
        b=sxdbgUE2Kaq4uw7gb73QHsWD6/kz3qaXOp4jtlQQ8zCWOGZchRXoS9h1kgGVgmwHMi
         0ovyZTnHlEv8jIe/t0cC86uBkO99V4EO8Uz5f6uPSjIGlmCW5dfk1M/WMMgmw59b/Vmr
         UaAH/7kYp3jq0L4a5oBQkDjGGm033na3bYjkJ0PSfFUGgdKTwJTImQPUAtxcu7+XlXvz
         2OjxZNPuXaMG+w58a5/U0wluu/5+wyuuUTsalUysgAJrKHCGhlMohRLo/Ao6Rozoy4M7
         vVa7GkNVeu1ikZU3b0NanTzbgz4haCidvDdbWRXlged7lJSNBHh2Wh1Z5C1S+UV2V2iS
         oshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b5EuL+gbnNFQ87YRYoAKBwPNNldsvEmstfa9tdC1Qjw=;
        b=qG9eUuNW6djChbqPB37lcqmFR4CQ8c/J86VmtXpw/74iVFR+4mkIpeCEzXdokHKoE/
         LKm8ajjFyAMgQEwn745M+8+PqlnmCg4z1VgdwQjqHBoaKZdaZARJsRGWBusDLNDFa0Ij
         cS/xeA4LpoyS6dAPNi44IZit1E3gkTyyNsDLUDNszkZHDVICzQ/UvVjtDDt8ZtZgsQa+
         RP7QWAW2MryMAlsNpMQNnfkGvW5EtJxrguTpJm5Pjk1nLch3Ce8ly/sfC4gp4I/V/sEP
         Ceh9qF5hiT2npuvHNDLUNG0LkPOQB5cAV6oPcHXcs70GNiUC6OGGTbBnkdrMcZDF4lRq
         CrIA==
X-Gm-Message-State: AOAM533I60CRv/VDTRCLswCAl0IIPw96hEpiLB1j64oVmcEfE9pfvU4v
        HJbhLiETSb5C5pf2/oOf7dMymONxGhDTrJZbCg8qfg==
X-Google-Smtp-Source: ABdhPJzDKroUOn9WqA656ToUno9/DwyrFz+qIKbK639QDjkL6PIrlSnozMRN4BUf4+XJE6GzN91N3kg09SPyqja93/0=
X-Received: by 2002:ac2:4ed4:0:b0:44a:212e:fa1a with SMTP id
 p20-20020ac24ed4000000b0044a212efa1amr11109703lfr.372.1648744360087; Thu, 31
 Mar 2022 09:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220331105005.2580771-1-ivecera@redhat.com> <YkWpNVXYEBo/u3dm@boxer>
 <YkWp5JJ9Sp6UCTw7@boxer>
In-Reply-To: <YkWp5JJ9Sp6UCTw7@boxer>
From:   Brett Creeley <brett@pensando.io>
Date:   Thu, 31 Mar 2022 09:32:31 -0700
Message-ID: <CAFWUkrTzE87bduD431nu11biHi78XFitUWQfiwcU6_4UPU9FBg@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net] ice: Fix incorrect locking in ice_vc_process_vf_msg()
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>, mschmidt@redhat.com,
        open list <linux-kernel@vger.kernel.org>, poros@redhat.com,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>, jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 6:17 AM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Mar 31, 2022 at 03:14:32PM +0200, Maciej Fijalkowski wrote:
> > On Thu, Mar 31, 2022 at 12:50:04PM +0200, Ivan Vecera wrote:
> > > Usage of mutex_trylock() in ice_vc_process_vf_msg() is incorrect
> > > because message sent from VF is ignored and never processed.
> > >
> > > Use mutex_lock() instead to fix the issue. It is safe because this
> >
> > We need to know what is *the* issue in the first place.
> > Could you please provide more context what is being fixed to the readers
> > that don't have an access to bugzilla?
> >
> > Specifically, what is the case that ignoring a particular message when
> > mutex is already held is a broken behavior?
>
> Uh oh, let's
> CC: Brett Creeley <brett@pensando.io>

My concern here is that we don't want to handle messages
from the context of the "previous" VF configuration if that
makes sense.

It might be best to grab the cfg_lock before doing any
message/VF validating in ice_vc_process_vf_msg() to
make sure all of the checks are done under the cfg_lock.

CC'ing Jake so he can provide some input as
well.

>
> >
> > > mutex is used to prevent races between VF related NDOs and
> > > handlers processing request messages from VF and these handlers
> > > are running in ice_service_task() context.
> > >
> > > Fixes: e6ba5273d4ed ("ice: Fix race conditions between virtchnl handling and VF ndo ops")
> > > Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> > > ---
> > >  drivers/net/ethernet/intel/ice/ice_virtchnl.c | 10 +---------
> > >  1 file changed, 1 insertion(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> > > index 3f1a63815bac..9bf5bb008128 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> > > @@ -3660,15 +3660,7 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event)
> > >             return;
> > >     }
> > >
> > > -   /* VF is being configured in another context that triggers a VFR, so no
> > > -    * need to process this message
> > > -    */
> > > -   if (!mutex_trylock(&vf->cfg_lock)) {
> > > -           dev_info(dev, "VF %u is being configured in another context that will trigger a VFR, so there is no need to handle this message\n",
> > > -                    vf->vf_id);
> > > -           ice_put_vf(vf);
> > > -           return;
> > > -   }
> > > +   mutex_lock(&vf->cfg_lock);
> > >
> > >     switch (v_opcode) {
> > >     case VIRTCHNL_OP_VERSION:
> > > --
> > > 2.34.1
> > >
> > > _______________________________________________
> > > Intel-wired-lan mailing list
> > > Intel-wired-lan@osuosl.org
> > > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
