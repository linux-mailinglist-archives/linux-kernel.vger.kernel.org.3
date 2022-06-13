Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C6E54A13B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbiFMVTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352565AbiFMVSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:18:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B91DD8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:01:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA242612AC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 21:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAC3C3411C;
        Mon, 13 Jun 2022 21:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655154112;
        bh=vcKhLJGty8fRjACIP56lec3c1EKA3zWGxjiI4GHW7hE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=N61NkFAnobZGU9JICOgwqYhN4nDjiVuFw+blY5ECbPgDZfZYymS4/kjTl+NAdwonV
         SKJWaDjlZL3LtEN9PlwOCOlmq2up8jeENuMESIkM7ytyV6s3X7MpEJ83hbjMY8BJTP
         i6/X2JQB0hgmNUz+Wq8cu7kE0n1jZ5cKnFZ/XritiMvTWAUqWszooEKTDYnQb9OIMV
         Irn3ILHUsGOsayNPoJOFP0gKo/XX14Ud2VeK3AuzSpDrNm6Zrt/vX2dVZa+spK9SMy
         KivWf+TnmoH9n4KlJ7QAUSsHVxytknolmH69TxrHQToRFlN78VSYWAGkvBazJOxObN
         Vo3iczqtuU+wQ==
Message-ID: <9a7e0b6087540c9f868d60cbfc88ccefa8070a1b.camel@kernel.org>
Subject: Re: [PATCH v4 1/3] tracing: eprobe: remove duplicate is_good_name()
 operation
From:   Tom Zanussi <zanussi@kernel.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 13 Jun 2022 16:01:49 -0500
In-Reply-To: <1654171861-24014-2-git-send-email-quic_linyyuan@quicinc.com>
References: <1654171861-24014-1-git-send-email-quic_linyyuan@quicinc.com>
         <1654171861-24014-2-git-send-email-quic_linyyuan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGluaHUsCgpPbiBUaHUsIDIwMjItMDYtMDIgYXQgMjA6MTAgKzA4MDAsIExpbnl1IFl1YW4g
d3JvdGU6Cj4gdHJhY2Vwcm9iZV9wYXJzZV9ldmVudF9uYW1lKCkgYWxyZWFkeSB2YWxpZGF0ZSBn
cm91cCBhbmQgZXZlbnQgbmFtZSwKPiB0aGVyZSBpcyBubyBuZWVkIHRvIGNhbGwgaXNfZ29vZF9u
YW1lKCkgYWZ0ZXIgaXQuCj4gCj4gU2lnbmVkLW9mZi1ieTogTGlueXUgWXVhbiA8cXVpY19saW55
eXVhbkBxdWljaW5jLmNvbT4KPiAtLS0KPiB2MjogZHJvcCB2MSBjaGFuZ2UgYXMgaXQgaXMgTkFD
Sy4KPiDCoMKgwqAgYWRkIGl0IHRvIHJlbW92ZSBkdXBsaWNhdGUgaXNfZ29vZF9uYW1lKCkuCj4g
djM6IG1vdmUgaXQgYXMgZmlyc3QgcGF0Y2guCj4gdjQ6IG5vIGNoYW5nZQo+IAo+IMKga2VybmVs
L3RyYWNlL3RyYWNlX2Vwcm9iZS5jIHwgNCAtLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgNCBkZWxl
dGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEva2VybmVsL3RyYWNlL3RyYWNlX2Vwcm9iZS5jCj4g
Yi9rZXJuZWwvdHJhY2UvdHJhY2VfZXByb2JlLmMKPiBpbmRleCA3ZDQ0Nzg1Li4xN2Q2NGUzIDEw
MDY0NAo+IC0tLSBhL2tlcm5lbC90cmFjZS90cmFjZV9lcHJvYmUuYwo+ICsrKyBiL2tlcm5lbC90
cmFjZS90cmFjZV9lcHJvYmUuYwo+IEBAIC04NzgsMTYgKzg3OCwxMiBAQCBzdGF0aWMgaW50IF9f
dHJhY2VfZXByb2JlX2NyZWF0ZShpbnQgYXJnYywKPiBjb25zdCBjaGFyICphcmd2W10pCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzYW5pdGl6ZV9ldmVudF9uYW1lKGJ1ZjEpOwo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXZlbnQgPSBidWYxOwo+IMKgwqDCoMKg
wqDCoMKgwqB9Cj4gLcKgwqDCoMKgwqDCoMKgaWYgKCFpc19nb29kX25hbWUoZXZlbnQpIHx8ICFp
c19nb29kX25hbWUoZ3JvdXApKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3Rv
IHBhcnNlX2Vycm9yOwoKdHJhY2Vwcm9iZV9wYXJzZV9ldmVudF9uYW1lKCkgaXMgb25seSBjYWxs
ZWQgaWYgKGV2ZW50KS4gIEluIHRoZQohZXZlbnTCoGNhc2UsIHdvdWxkbid0IHRoZSBpc19nb29k
X25hbWUoKSBjaGVja3Mgc3RpbGwgYmUgbmVlZGVkIChzaW5jZQppbiB0aGF0IGNhc2UgYnVmMSBp
cyBhc3NpZ25lZCB0byBldmVudCk/Cgo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoHN5c19ldmVudCA9
IGFyZ3ZbMV07Cj4gwqDCoMKgwqDCoMKgwqDCoHJldCA9IHRyYWNlcHJvYmVfcGFyc2VfZXZlbnRf
bmFtZSgmc3lzX2V2ZW50LCAmc3lzX25hbWUsCj4gYnVmMiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHN5c19ldmVudCAtIGFyZ3ZbMV0pOwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAocmV0IHx8
ICFzeXNfbmFtZSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gcGFyc2Vf
ZXJyb3I7Cj4gLcKgwqDCoMKgwqDCoMKgaWYgKCFpc19nb29kX25hbWUoc3lzX2V2ZW50KSB8fCAh
aXNfZ29vZF9uYW1lKHN5c19uYW1lKSkKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Z290byBwYXJzZV9lcnJvcjsKCkkgYWdyZWUgdGhpcyBvbmUgaXNuJ3QgbmVlZGVkLgoKVGhhbmtz
LAoKVG9tCgo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoG11dGV4X2xvY2soJmV2ZW50X211dGV4KTsK
PiDCoMKgwqDCoMKgwqDCoMKgZXZlbnRfY2FsbCA9IGZpbmRfYW5kX2dldF9ldmVudChzeXNfbmFt
ZSwgc3lzX2V2ZW50KTsKCg==

