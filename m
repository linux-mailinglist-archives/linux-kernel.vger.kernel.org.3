Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9572500AA9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiDNKAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiDNKA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:00:29 -0400
X-Greylist: delayed 154583 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 02:58:04 PDT
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570C96E540
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:58:04 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id 592E6B002FC; Thu, 14 Apr 2022 11:58:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 57F2BB00268;
        Thu, 14 Apr 2022 11:58:01 +0200 (CEST)
Date:   Thu, 14 Apr 2022 11:58:01 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
cc:     Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 23/23] mm/sl[au]b: check if large object is valid in
 __ksize()
In-Reply-To: <20220414085727.643099-24-42.hyeyoo@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2204141156160.690844@gentwo.de>
References: <20220414085727.643099-1-42.hyeyoo@gmail.com> <20220414085727.643099-24-42.hyeyoo@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022, Hyeonggon Yoo wrote:

> If address of large object is not beginning of folio or size of
> the folio is too small, it must be invalid. Return zero in such cases.

This looks like a slab usage error on the part of the caller that would
benefit from a kernel log entry. A warning or an error?
