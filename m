Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1824527FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbiEPI1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiEPI1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:27:14 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C837C03;
        Mon, 16 May 2022 01:27:13 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 3C63F3200986;
        Mon, 16 May 2022 04:27:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 16 May 2022 04:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1652689629; x=1652776029; bh=MZNQjE5GQn
        lCj1RALxdmRV19EfrIJQgMeRRKpZ1u76A=; b=QdgxKZnJUjh2x0UPE5atrIpngF
        sJlIcJpxcVMGtInTaDraI2+U7rf4LYs0zuKdNfWyLQZFgpdTI+zIZg/y4IUUvJvf
        H+p5sAEyClnXJADeeedjs1fmV/y3OesqpO7Hjhf9gmV3JascfduCo2fk5+JmprP+
        MSJ8LIOdlv28JlBYIhp8j27yGzsG36XE3XoK848fe3aXVdM5Gr2A2uqyxp8lEU+M
        a5lzFk42oVwlpxXOT/I5YJCcp8ait4vlT5G6TAlh7VXT6eVIUzbJS8kVJLx1abza
        Won3aPK4oZ1sznLl7NNZCK4ml36sHdawyJQMSJnC2MEc+t7MX+gOarHoV4Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1652689629; x=
        1652776029; bh=MZNQjE5GQnlCj1RALxdmRV19EfrIJQgMeRRKpZ1u76A=; b=a
        FWLbqulkUMSRjFAVzi+NinOdK6KNmgkiVpSXS2xcz+JPFI2VgTIhMlToT+n4ayiw
        8mjNKxdcJgKpe1gUIJuqydsVvHPaCCagQPTD1JnAMDRlTK1J3eICJJyttOp3WtaC
        npzeqB+YhUjkiH6YxgTwwgusuoo24hyHFNBSo0OWkaz9ryBPggbEKe8NgSSxhQd4
        no4408DckrA9x5wClv2ViSksFgJ2e7JQoKwwLiR8IRFdb5BnjsNqysORWnOWd8N5
        lfECJsdS5ZNQmxXGsJpce9wnNPpnFcF/lvgTgED9EkxFeIFsYiR5SpfLfco+LUj7
        rSOAEOOa7eO5GnZu5rVkw==
X-ME-Sender: <xms:3QqCYhGsvIYTw4nPePHdWrMVSZycOt8DWglv2_afzc1uO9QDnIeGlQ>
    <xme:3QqCYmWljoa6ezUlr45u1VfwRyvEO1nc3suNUZm7r4gsclgyJ9hNg3igUO-GLwQBv
    FhJA1ZOHoOamQ>
X-ME-Received: <xmr:3QqCYjKC0XlS2mY_XHqONsBxWdGpIUtTeDQAxrdiLKYuEgaljSsntKktQka9lj5UJZNQfuOk7yMUobLAOomxN2RDZaStRJBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrheehgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpedvjefhve
    fhjeejfeefleejteegtedvgeeghfeuveevgfffueelhffhhedugffhkeenucffohhmrghi
    nhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:3QqCYnHHKMBB1m5rOIox-KqIDfFMYOyQ7PCQZTyyX_ZIo1DlYNVUyQ>
    <xmx:3QqCYnU1_IoskWBffWK2spVrX19s5gQGm8z4UoTEfEeGfo0dR1c9-A>
    <xmx:3QqCYiN9LAQac00YBKQoEmKMSaqkID8LmfpNYTADR83hSZFa6fdXaQ>
    <xmx:3QqCYlll7wSu6o6Pe3eG_-Jl-Umou25ltZ5OwbGGFrh1KLC7IbV-sg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 May 2022 04:27:08 -0400 (EDT)
Date:   Mon, 16 May 2022 10:27:06 +0200
From:   Greg KH <greg@kroah.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Alex Gaynor <alex.gaynor@gmail.com>,
        Carlos Llamas <cmllamas@google.com>,
        Finn Behrens <me@kloenk.de>, Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wayne Campbell <wcampbell1995@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the rust tree with the char-misc tree
Message-ID: <YoIK2l6xbQMPGZHy@kroah.com>
References: <20220516171329.6b10e4e5@canb.auug.org.au>
 <YoIB8WCdgHr6Cp+z@kroah.com>
 <CANiq72mtirFqVr9eHnh9Y=nAbBZcNxspdLoWKzvwmvjHfvBQ4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mtirFqVr9eHnh9Y=nAbBZcNxspdLoWKzvwmvjHfvBQ4w@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 10:18:45AM +0200, Miguel Ojeda wrote:
> Hi Greg,
> 
> On Mon, May 16, 2022 at 9:49 AM Greg KH <greg@kroah.com> wrote:
> >
> > Odd, why does the Rust binder implementation require the IOCTL
> > definitions to be in an enum instead of a #define?
> 
> It is because bindgen (the tool which generates the "raw" C bindings)
> only works with simple C `#define`s. Thus there are two options when
> one hits something like this: either copy-paste them manually into the
> Rust side (which adds maintenance), or change them into real
> objects/identifiers in the C side.
> 
> There may be support in the future for expanding macros that end up in
> a numeric one: https://github.com/rust-lang/rust-bindgen/issues/753.
> 
> Stephen: the resolution looks fine, thanks!
> 
> > If that's required, I can take that type of change now to prevent merge
> > issues in the future.
> 
> We have two so far: this one (for the RFC Android patch) and another
> small one in include/linux/spinlock.h (for the `sync` module).
> 
> So far I have put those changes in their respective patches, but if
> you prefer I can send them independently too (like the prerequisite
> patches).

The binder one I can take now if you want to send that to me, as that
would make your development life easier.

thanks,

greg k-h
