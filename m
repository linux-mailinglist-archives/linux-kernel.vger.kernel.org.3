Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7190157147D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiGLI1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGLI1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:27:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A1587AC32
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657614471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JfQPW3k4yk+c+WSzuz95pilpy8J3eRh/AKdyQJaLcpA=;
        b=ehHjDGDkJ7ESswwrTNRHrKKB5Nsuz34uufnYKV6bE2HAz23pcz9SSyaCduF83iTSoC282H
        R++KNY9VT1pdZIl1NWgfY9ign6hMYMVacEMoTYfSSBFXcx0PEOJ7zc7nEsHbl+sYHWquZs
        smkkLFsNLdUjQ29We0etTwI0UsKah90=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-218-G2aXSD2gOTaSFOdbNvk_sA-1; Tue, 12 Jul 2022 04:27:49 -0400
X-MC-Unique: G2aXSD2gOTaSFOdbNvk_sA-1
Received: by mail-wr1-f70.google.com with SMTP id o1-20020adfba01000000b0021b90bd28d2so1181795wrg.14
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JfQPW3k4yk+c+WSzuz95pilpy8J3eRh/AKdyQJaLcpA=;
        b=Nq/VB6X9d6FlgwirImBa2xXNtEpOFVyoUVZNLqa3flhIeyhQ4BsHyOquA9pMEZ7oU1
         J5RDakVUUFPji8csA3/yK0NF6cuoMXbQuMWH2AIcPp1MQI4aZ8yw3XYc9mflYH6+w/pd
         ms2IlqWbeY1raaMFvaDp7lzd1SIwXrn51O+g2b/HH0xF+3gM5FmKMELJS2ZWrYkKaWUO
         XbOduY+VBsViNNR6tKiC65XuTqFRM85RRHZgFKuLqr3n0TgpAcNMwFg6yvgABivU49sb
         tNi9W839gLNQCijJBFzj6nn0kuiKqI2Nqxt3WUj6+DCRiJZp1237WqYd1Y0948okkT+f
         1eCQ==
X-Gm-Message-State: AJIora+ioFLOzd2NO4RZnQ6y4Zn46ngaZzuGA+6zHT7D2/s4K7kylgEe
        r+ToLEEUM+55ZzFyoU1l1L7L3o5Q4M7OW3MbShfGkDAoxMIteGR+NHWk4r1FSxrfBkag03rD4xs
        viomS8zdGnHazBLOBp0fs9kg2
X-Received: by 2002:a5d:47c7:0:b0:21d:ac9c:571c with SMTP id o7-20020a5d47c7000000b0021dac9c571cmr5343429wrc.522.1657614468441;
        Tue, 12 Jul 2022 01:27:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vgHRgKKemP017DzVbNknW+teMH9jsqa+xDB8nk5dZ4JSOVijFqOtntpmRtqeWasPBVM0vCiA==
X-Received: by 2002:a5d:47c7:0:b0:21d:ac9c:571c with SMTP id o7-20020a5d47c7000000b0021dac9c571cmr5343413wrc.522.1657614468244;
        Tue, 12 Jul 2022 01:27:48 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id bh21-20020a05600c3d1500b003a2d6c623f3sm12364159wmb.19.2022.07.12.01.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 01:27:47 -0700 (PDT)
Date:   Tue, 12 Jul 2022 10:27:46 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Bruce Fields <bfields@fieldses.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] nfsd changes for 5.18
Message-ID: <20220712102746.5404e88a@redhat.com>
In-Reply-To: <20220711181941.GC14184@fieldses.org>
References: <EF97E1F5-B70F-4F9F-AC6D-7B48336AE3E5@oracle.com>
        <20220710124344.36dfd857@redhat.com>
        <B62B3A57-A8F7-478B-BBAB-785D0C2EE51C@oracle.com>
        <5268baed1650b4cba32978ad32d14a5ef00539f2.camel@redhat.com>
        <20220711181941.GC14184@fieldses.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2022 14:19:41 -0400
Bruce Fields <bfields@fieldses.org> wrote:

> On Mon, Jul 11, 2022 at 06:33:04AM -0400, Jeff Layton wrote:
> > On Sun, 2022-07-10 at 16:42 +0000, Chuck Lever III wrote:  
> > > > This patch regressed clients that support TIME_CREATE attribute.
> > > > Starting with this patch client might think that server supports
> > > > TIME_CREATE and start sending this attribute in its requests.  
> > > 
> > > Indeed, e377a3e698fb ("nfsd: Add support for the birth time
> > > attribute") does not include a change to nfsd4_decode_fattr4()
> > > that decodes the birth time attribute.
> > > 
> > > I don't immediately see another storage protocol stack in our
> > > kernel that supports a client setting the birth time, so NFSD
> > > might have to ignore the client-provided value.
> > >   
> > 
> > Cephfs allows this. My thinking at the time that I implemented it was
> > that it should be settable for backup purposes, but this was possibly a
> > mistake. On most filesystems, the btime seems to be equivalent to inode
> > creation time and is read-only.  
> 
> So supporting it as read-only seems reasonable.
> 
> Clearly, failing to decode the setattr attempt isn't the right way to do
> that.  I'm not sure what exactly it should be doing--some kind of
> permission error on any setattr containing TIME_CREATE?

erroring out on TIME_CREATE will break client that try to
set this attribute (legitimately). That's what by chance 
happening with current master (return error when TIME_CREATE
is present).

As long as server advertises support for TIME_CREATE
it should not error out when client sends it if spec permits
such use.

I think ignoring this attribute like Chuck has proposed
is acceptable (if one ignores archiving use case where
setting it makes sense).

Alternatively if folks inclined towards erroring out,
there should be a way to optout or optin from TIME_CREATE support,
to keep existing clients working + a sane error message so users
won't have to debug kernel to figure out what's wrong with
their setup.

> --b.
> 

