Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B79658A8E4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240541AbiHEJgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240497AbiHEJgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:36:31 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBAF76979
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 02:36:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659692131; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=HGNHEpDjMnxaaLGavAkDCfW+6RNU+cbd0+prbhfC1fJJ/1gZ2fUBaTW/OWb2QXvudVNlZWU6C1g3xgcc6mkWplLCckC4GHkxH03B4omSPvRjBmwpMgeuSdv8t1qze5uyjaL+RVt3oghdPRXB8lkxv1FEHMmX+AUvcdezuIiGb80=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659692131; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=f8615EGDWe44tvsYPbzBo/6/jTmVu1y7l7Pkq6Q/1Ig=; 
        b=LZADhVL2AimiA6NVc+Mn6E9OASVriJ3j5k8pYPe/+uFKy71X+4KbEZ339kmNqlDxhaq/O1piNnLpSQVjHtO6eEXdC7i+KXuxfTAXd6orpMDG4Ds8Y5CcLf9OTRsvC6WRcrT//9+LhjnGcaLdiS6EJuu/H7LXPkXPtee5rCLdNWU=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659692131;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=f8615EGDWe44tvsYPbzBo/6/jTmVu1y7l7Pkq6Q/1Ig=;
        b=ousbkyXkFzhAdKxN9NaAT/r1huPDwRekH4obymiGGeZWZKDOtdYxWT82xMxwyOKs
        hVB38twxtCHvlvCyAyUErrm5/J4r/zV64ILwDbVjsBrIE70BvFM85GZaL29Atf1AYfX
        LMQHhjPoYO4tt/FJWr20x7t34VhxXM3bVt5DoDSo=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1659692119211186.6606668834628; Fri, 5 Aug 2022 15:05:19 +0530 (IST)
Date:   Fri, 05 Aug 2022 15:05:19 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Eric Biggers" <ebiggers@kernel.org>
Cc:     "Jonathan Corbet" <corbet@lwn.net>,
        "David Howells" <dhowells@redhat.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        "Eric Dumazet" <edumazet@google.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Message-ID: <1826d5bf492.4777e628118669.6994537284529152343@siddh.me>
In-Reply-To: <YuzDwa4otHkImo10@sol.localdomain>
References: <cover.1659618705.git.code@siddh.me> <YuzDwa4otHkImo10@sol.localdomain>
Subject: Re: [PATCH 0/3] kernel/watch_queue: Clean up some code
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Aug 2022 12:46:17 +0530  Eric Biggers  wrote:
> I think patches 1 and 3 should be merged together.
> 
> Also, please use a consistent version number for all patches in the series.  You
> have a version 1, version 2, and version 4 patch all in the same series, which
> is very confusing.
> 
> - Eric
> 

Will do.

Sorry for the confusion.

Thanks,
Siddh
